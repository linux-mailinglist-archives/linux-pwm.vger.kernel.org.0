Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9C2732D0F
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Jun 2019 11:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfFCJoD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 3 Jun 2019 05:44:03 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:36318 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfFCJoD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 3 Jun 2019 05:44:03 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 759FF4CD5F; Mon,  3 Jun 2019 11:44:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 71BE04CD38;
        Mon,  3 Jun 2019 11:44:01 +0200 (CEST)
Date:   Mon, 3 Jun 2019 11:44:01 +0200 (CEST)
From:   Nikolaus Voss <nv@vosn.de>
X-X-Sender: nv@fox.voss.local
To:     Dan Murphy <dmurphy@ti.com>
cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 3/3] leds-pwm.c: support ACPI via firmware-node
 framework
In-Reply-To: <3c763c8f-985e-a292-1bd6-af20caab5239@ti.com>
Message-ID: <alpine.DEB.2.20.1906031129300.63281@fox.voss.local>
References: <cover.1559127603.git.nikolaus.voss@loewensteinmedical.de> <4f89c4b91cc918302a9d5a7eedfa39259a5583bb.1559127603.git.nikolaus.voss@loewensteinmedical.de> <3c763c8f-985e-a292-1bd6-af20caab5239@ti.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1402635251-1559555041=:63281"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1402635251-1559555041=:63281
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

Dan,

On Thu, 30 May 2019, Dan Murphy wrote:
>
> On 5/29/19 7:18 AM, Nikolaus Voss wrote:
>> DT specific handling is replaced by firmware-node abstration to support
>> ACPI specification of PWM LEDS.
>>
>> Example ASL:
>> Device (PWML)
>> {
>>      Name (_HID, "PRP0001")
>>      Name (_DSD, Package () {
>>            ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>>            Package () { Package () {"compatible",
>>                                      Package () {"pwm-leds"}}}})
>>
>>      Device (PWL0)
>>      {
>>          Name (_HID, "PRP0001")
>>          Name (_DSD, Package () {
>>                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>>                Package () {
>>                             Package () {"label", "alarm-led"},
>>                             Package () {"pwms", Package ()
>>                                         {\_SB_.PCI0.PWM, 0, 600000, 0}},
>>                             Package () {"linux,default-state", "off"}}})
>>      }
>> }
>>
>> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
>> ---
>>   drivers/leds/leds-pwm.c | 44 ++++++++++++++++++++++++-----------------
>>   1 file changed, 26 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
>> index af08bcdc4fd8..cc717dd6a12c 100644
>> --- a/drivers/leds/leds-pwm.c
>> +++ b/drivers/leds/leds-pwm.c
>> @@ -75,7 +75,7 @@ static inline size_t sizeof_pwm_leds_priv(int num_leds)
>>   }
>>
>>   static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
>> -		       struct led_pwm *led, struct device_node *child)
>> +		       struct led_pwm *led, struct fwnode_handle *fwnode)
>>   {
>>   	struct led_pwm_data *led_data = &priv->leds[priv->num_leds];
>>   	struct pwm_args pargs;
>> @@ -88,8 +88,8 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
>>   	led_data->cdev.max_brightness = led->max_brightness;
>>   	led_data->cdev.flags = LED_CORE_SUSPENDRESUME;
>>
>> -	if (child)
>> -		led_data->pwm = devm_of_pwm_get(dev, child, NULL);
>> +	if (fwnode)
>> +		led_data->pwm = devm_fwnode_pwm_get(dev, fwnode, NULL);
>>   	else
>>   		led_data->pwm = devm_pwm_get(dev, led->name);
>>   	if (IS_ERR(led_data->pwm)) {
>> @@ -114,7 +114,8 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
>>   	if (!led_data->period && (led->pwm_period_ns > 0))
>>   		led_data->period = led->pwm_period_ns;
>>
>> -	ret = devm_of_led_classdev_register(dev, child, &led_data->cdev);
>> +	ret = devm_of_led_classdev_register(dev, to_of_node(fwnode),
>> +					    &led_data->cdev);
>>   	if (ret == 0) {
>>   		priv->num_leds++;
>>   		led_pwm_set(&led_data->cdev, led_data->cdev.brightness);
>> @@ -126,27 +127,34 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
>>   	return ret;
>>   }
>>
>> -static int led_pwm_create_of(struct device *dev, struct led_pwm_priv *priv)
>> +static int led_pwm_create_fwnode(struct device *dev, struct led_pwm_priv *priv)
>>   {
>> -	struct device_node *child;
>> +	struct fwnode_handle *fwnode;
>>   	struct led_pwm led;
>>   	int ret = 0;
>>
>>   	memset(&led, 0, sizeof(led));
>>
>> -	for_each_child_of_node(dev->of_node, child) {
>> -		led.name = of_get_property(child, "label", NULL) ? :
>> -			   child->name;
>> +	device_for_each_child_node(dev, fwnode) {
>> +		ret = fwnode_property_read_string(fwnode, "label", &led.name);
>> +		if (ret && is_of_node(fwnode))
>> +			led.name = to_of_node(fwnode)->name;
>
> new line
ok

>
>
>> +		if (!led.name) {
>> +			fwnode_handle_put(fwnode);
>> +			return -EINVAL;
>> +		}
>
> 'label' is an optional parameter for device tree returning here makes it
> required.
>
> Maybe derive a default name.  There is a patch series which is going to
> modify how labels are created for LED class devices.
>
> https://lore.kernel.org/patchwork/project/lkml/list/?series=391005

Looks interesting, thanks for the pointer. But that would be a second 
step.

My patch handles name derivation the same way as the leds-gpio driver 
already does. I think it should be handled consistently among drivers of 
the same sub-system.

Nikolaus
--8323329-1402635251-1559555041=:63281--
