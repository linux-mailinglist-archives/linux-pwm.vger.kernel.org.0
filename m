Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7D32FF23
	for <lists+linux-pwm@lfdr.de>; Thu, 30 May 2019 17:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfE3POs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 30 May 2019 11:14:48 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:44372 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3POr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 30 May 2019 11:14:47 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4UFEXeY070295;
        Thu, 30 May 2019 10:14:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559229273;
        bh=ija2CP43k/HJ3UFzMPN6ji2dFsdMVgUAdQ28mpdCZSI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dZiT56ALKGxAUt4LMVTjbpfFl82LBXrROu/AttXlObJIQuVjD0SLgnato957Ydx8c
         0b0gLty+XWKu/gjYgdt/UEGjdidC4IjIrkIInK35xSIrPuU0vOdEyPHU5IxtM6yBxJ
         OgKa6l/6F8xtTig6o3GyOuZ7n3m4D4036zmAmIwg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4UFEXe0089410
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 May 2019 10:14:33 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 30
 May 2019 10:14:32 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 30 May 2019 10:14:32 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4UFEWj1069622;
        Thu, 30 May 2019 10:14:32 -0500
Subject: Re: [PATCH 3/3] leds-pwm.c: support ACPI via firmware-node framework
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-acpi@vger.kernel.org>, <devel@acpica.org>,
        <linux-leds@vger.kernel.org>, <linux-pwm@vger.kernel.org>
References: <cover.1559127603.git.nikolaus.voss@loewensteinmedical.de>
 <4f89c4b91cc918302a9d5a7eedfa39259a5583bb.1559127603.git.nikolaus.voss@loewensteinmedical.de>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <3c763c8f-985e-a292-1bd6-af20caab5239@ti.com>
Date:   Thu, 30 May 2019 10:14:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4f89c4b91cc918302a9d5a7eedfa39259a5583bb.1559127603.git.nikolaus.voss@loewensteinmedical.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On 5/29/19 7:18 AM, Nikolaus Voss wrote:
> DT specific handling is replaced by firmware-node abstration to support
> ACPI specification of PWM LEDS.
>
> Example ASL:
> Device (PWML)
> {
>      Name (_HID, "PRP0001")
>      Name (_DSD, Package () {
>            ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>            Package () { Package () {"compatible",
>                                      Package () {"pwm-leds"}}}})
>
>      Device (PWL0)
>      {
>          Name (_HID, "PRP0001")
>          Name (_DSD, Package () {
>                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                Package () {
>                             Package () {"label", "alarm-led"},
>                             Package () {"pwms", Package ()
>                                         {\_SB_.PCI0.PWM, 0, 600000, 0}},
>                             Package () {"linux,default-state", "off"}}})
>      }
> }
>
> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> ---
>   drivers/leds/leds-pwm.c | 44 ++++++++++++++++++++++++-----------------
>   1 file changed, 26 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
> index af08bcdc4fd8..cc717dd6a12c 100644
> --- a/drivers/leds/leds-pwm.c
> +++ b/drivers/leds/leds-pwm.c
> @@ -75,7 +75,7 @@ static inline size_t sizeof_pwm_leds_priv(int num_leds)
>   }
>   
>   static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
> -		       struct led_pwm *led, struct device_node *child)
> +		       struct led_pwm *led, struct fwnode_handle *fwnode)
>   {
>   	struct led_pwm_data *led_data = &priv->leds[priv->num_leds];
>   	struct pwm_args pargs;
> @@ -88,8 +88,8 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
>   	led_data->cdev.max_brightness = led->max_brightness;
>   	led_data->cdev.flags = LED_CORE_SUSPENDRESUME;
>   
> -	if (child)
> -		led_data->pwm = devm_of_pwm_get(dev, child, NULL);
> +	if (fwnode)
> +		led_data->pwm = devm_fwnode_pwm_get(dev, fwnode, NULL);
>   	else
>   		led_data->pwm = devm_pwm_get(dev, led->name);
>   	if (IS_ERR(led_data->pwm)) {
> @@ -114,7 +114,8 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
>   	if (!led_data->period && (led->pwm_period_ns > 0))
>   		led_data->period = led->pwm_period_ns;
>   
> -	ret = devm_of_led_classdev_register(dev, child, &led_data->cdev);
> +	ret = devm_of_led_classdev_register(dev, to_of_node(fwnode),
> +					    &led_data->cdev);
>   	if (ret == 0) {
>   		priv->num_leds++;
>   		led_pwm_set(&led_data->cdev, led_data->cdev.brightness);
> @@ -126,27 +127,34 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
>   	return ret;
>   }
>   
> -static int led_pwm_create_of(struct device *dev, struct led_pwm_priv *priv)
> +static int led_pwm_create_fwnode(struct device *dev, struct led_pwm_priv *priv)
>   {
> -	struct device_node *child;
> +	struct fwnode_handle *fwnode;
>   	struct led_pwm led;
>   	int ret = 0;
>   
>   	memset(&led, 0, sizeof(led));
>   
> -	for_each_child_of_node(dev->of_node, child) {
> -		led.name = of_get_property(child, "label", NULL) ? :
> -			   child->name;
> +	device_for_each_child_node(dev, fwnode) {
> +		ret = fwnode_property_read_string(fwnode, "label", &led.name);
> +		if (ret && is_of_node(fwnode))
> +			led.name = to_of_node(fwnode)->name;

new line


> +		if (!led.name) {
> +			fwnode_handle_put(fwnode);
> +			return -EINVAL;
> +		}

'label' is an optional parameter for device tree returning here makes it 
required.

Maybe derive a default name.  There is a patch series which is going to 
modify how labels are created for LED class devices.

https://lore.kernel.org/patchwork/project/lkml/list/?series=391005

>   
> -		led.default_trigger = of_get_property(child,
> -						"linux,default-trigger", NULL);
> -		led.active_low = of_property_read_bool(child, "active-low");
> -		of_property_read_u32(child, "max-brightness",
> -				     &led.max_brightness);
> +		fwnode_property_read_string(fwnode, "linux,default-trigger",
> +					    &led.default_trigger);
>   
> -		ret = led_pwm_add(dev, priv, &led, child);
> +		led.active_low = fwnode_property_read_bool(fwnode,
> +							   "active-low");
> +		fwnode_property_read_u32(fwnode, "max-brightness",
> +					 &led.max_brightness);
> +
> +		ret = led_pwm_add(dev, priv, &led, fwnode);
>   		if (ret) {
> -			of_node_put(child);
> +			fwnode_handle_put(fwnode);
>   			break;
>   		}
>   	}
> @@ -164,7 +172,7 @@ static int led_pwm_probe(struct platform_device *pdev)
>   	if (pdata)
>   		count = pdata->num_leds;
>   	else
> -		count = of_get_child_count(pdev->dev.of_node);
> +		count = device_get_child_node_count(&pdev->dev);
>   
>   	if (!count)
>   		return -EINVAL;
> @@ -182,7 +190,7 @@ static int led_pwm_probe(struct platform_device *pdev)
>   				break;
>   		}
>   	} else {
> -		ret = led_pwm_create_of(&pdev->dev, priv);
> +		ret = led_pwm_create_fwnode(&pdev->dev, priv);
>   	}
>   
>   	if (ret)
