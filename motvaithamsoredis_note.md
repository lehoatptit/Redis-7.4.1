RDB: Toàn bộ dữ liệu chạy trên RAM sẽ được lưu vào một single-file point-in-time .RDB, bạn có thể restore lại database vào các thời điểm khác nhau mà chỉ cần sử dụng file snapshot này. Hạn chế của RDB là file snapshot chỉ được tạo sau 1 khoảng thời gian hoặc sau một lượng write-records nhất định, chẳng hạn như sau mỗi 5 phút hoặc sau 100 lần ghi thì Redis mới cập nhật vào file .RDB. Do đó, nếu Redis bị crash hoặc hệ thống gặp sự cố, các dữ liệu gần nhất sẽ bị mất.

AOF: Append to file. Redis sẽ liên tục lưu dữ liệu vào file log, chúng ta có thể cấu hình policy để Redis lưu log mỗi giây hoặc bất cứ khi nào có records mới sẽ đều lưu vào file log. Như vậy sẽ giảm thiểu được việc mất dữ liệu nếu xảy ra sự cố. Tuy nhiên phương pháp này sẽ dùng nhiều dung lượng Disk hơn RDB và sẽ ảnh hưởng tới Performance nếu hệ thống đang trong tình trạng High Load.
Mặc định khi cài đặt RDB đã được enable, chúng ta sẽ cấu hình thêm AOF như sau:

Mở file /etc/redis.conf và cấu hình các tham số như sau:

appendonly yes
appendfsync everysec
Cấu hình cho Redis tận dụng tối đa tài nguyên RAM

Mở file /etc/sysctl.conf và thêm vào cấu hình sau:

vm.overcommit_memory = 1
Restart hệ thống để option này có tác dụng.

Các bạn nên kiểm tra phần SWAP của hệ thống đã có chưa nhé, nếu chưa có cần phải add thêm lượng SWAP = RAM để đảm bảo Redis luôn có thể sử dụng tối đa tài nguyên của máy chủ.
Cấu hình tại Server Master

Tại server Master, các bạn đảm bảo là Redis listen trên IP mà bạn muốn cấu hình, mở file /etc/redis.conf và thêm vào cấu hình sau

bind 127.0.0.1 [your ip public]
Restart Redis

systemctl restart redis
Cấu hình tại Server Slave

Các bạn mở file /etc/redis.conf và thêm vào cuối file

slaveof [master server ip public] 6379
Restart Redis

systemctl restart redis
