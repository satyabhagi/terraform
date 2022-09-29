variable "my_instance_type" {
    type = string
}


variable "instance_tags" {
   type = object({
         Name = string
         foo = number
   })
}