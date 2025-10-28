Return-Path: <linux-pwm+bounces-7502-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BE6C137BF
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Oct 2025 09:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4D7C1A228B3
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Oct 2025 08:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B502D46CE;
	Tue, 28 Oct 2025 08:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="SB3GWG7T"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-m49200.qiye.163.com (mail-m49200.qiye.163.com [45.254.49.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04AD27FD62;
	Tue, 28 Oct 2025 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761639396; cv=none; b=oaH1ow0qsZNj/+ZbitDlmZtLLjGVg+eJt479+1Tk+sitvyJY4ZGfHCwaM6m95TrUh+43eBP3eTnBLBEX8S9n0UF7uEp7QDoeCXeJTxFMkafOrNKiVlRGf+Be3CURZw7ctVRTgyf9CtqaxbRDM+ANOTQsbUI71y5//fQc2tDC0VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761639396; c=relaxed/simple;
	bh=vY09GGJJeSsAczwhvFSK2fxIUbQ9yAIAwFhyrfx8GqM=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=O0hObttWwVYJxiQ42T+02g8JLskqz6Goq0OlPc3Rasti/rTH7LGt+PfgULJCndV+DHwQZ6BsjB2FHPsEbQmQ/Ov9sR7q2uh/xQ/et/trIr/dMtzAkLiaiBnRKF9F/KtL7gDAjs7H49KNMD+sNwvnbId37sbwYJ4txG/NUOOZZy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=SB3GWG7T; arc=none smtp.client-ip=45.254.49.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.26] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 277602d99;
	Tue, 28 Oct 2025 16:16:27 +0800 (GMT+08:00)
Content-Type: multipart/mixed; boundary="------------PdXS0cE3u8xAHvhAPnkRnp4J"
Message-ID: <8a6e920b-9565-4161-9d71-63f924593c23@rock-chips.com>
Date: Tue, 28 Oct 2025 16:16:26 +0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] pwm: Add rockchip PWMv4 driver
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Lee Jones <lee@kernel.org>, William Breathitt Gray <wbg@kernel.org>
Cc: kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
 Alexey Charkov <alchark@gmail.com>, linux-rockchip@lists.infradead.org,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20251027-rk3576-pwm-v3-0-654a5cb1e3f8@collabora.com>
 <20251027-rk3576-pwm-v3-3-654a5cb1e3f8@collabora.com>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20251027-rk3576-pwm-v3-3-654a5cb1e3f8@collabora.com>
X-HM-Tid: 0a9a29e3d04203a3kunma54aa20d1201d1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRhNHVYYGkJPHU5PHhpNHUhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=SB3GWG7T0SlKULOUlaw954l4NyDL+/Bzf8HSPCc4jUguT6hvhizVzYnaLQSSvWeM9oEUq6ff3MuChk3Ts9xBN5xTncQCaPBtW1XqOVC8PV4UY1lmOCCAB68DO6ZMey7vmjiErK5PUVOukLybRhiWCZOcd53xlul0/VsWkPBCO5o=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=K+6HGTgjaSvG82Coa3pZ418ociHvbPlPsxJ2duK2Hvo=;
	h=date:mime-version:subject:message-id:from;

This is a multi-part message in MIME format.
--------------PdXS0cE3u8xAHvhAPnkRnp4J
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Nicolas,

On 10/28/2025 1:11 AM, Nicolas Frattaroli wrote:
> The Rockchip RK3576 brings with it a new PWM IP, in downstream code
> referred to as "v4". This new IP is different enough from the previous
> Rockchip IP that I felt it necessary to add a new driver for it, instead
> of shoehorning it in the old one.
> 
> Add this new driver, based on the PWM core's waveform APIs. Its platform
> device is registered by the parent mfpwm driver, from which it also
> receives a little platform data struct, so that mfpwm can guarantee that
> all the platform device drivers spread across different subsystems for
> this specific hardware IP do not interfere with each other.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>   MAINTAINERS                   |   1 +
>   drivers/pwm/Kconfig           |  13 ++
>   drivers/pwm/Makefile          |   1 +
>   drivers/pwm/pwm-rockchip-v4.c | 353 ++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 368 insertions(+)
> 

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8f3235ba825e..2079c2d51d5c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22372,6 +22372,7 @@ L:	linux-rockchip@lists.infradead.org
>   L:	linux-pwm@vger.kernel.org
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/pwm/rockchip,rk3576-pwm.yaml
> +F:	drivers/pwm/pwm-rockchip-v4.c
>   F:	drivers/soc/rockchip/mfpwm.c
>   F:	include/soc/rockchip/mfpwm.h
>   
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index c2fd3f4b62d9..b852a7b2a29d 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -615,6 +615,19 @@ config PWM_ROCKCHIP
>   	  Generic PWM framework driver for the PWM controller found on
>   	  Rockchip SoCs.
>   
> +config PWM_ROCKCHIP_V4
> +	tristate "Rockchip PWM v4 support"
> +	depends on ARCH_ROCKCHIP || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	depends on MFD_ROCKCHIP_MFPWM
> +	help
> +	  Generic PWM framework driver for the PWM controller found on
> +	  later Rockchip SoCs such as the RK3576.
> +
> +	  Uses the Rockchip Multi-function PWM controller driver infrastructure
> +	  to guarantee fearlessly concurrent operation with other functions of
> +	  the same device implemented by drivers in other subsystems.
> +
>   config PWM_SAMSUNG
>   	tristate "Samsung PWM support"
>   	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index dfa8b4966ee1..fe0d16558d99 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -55,6 +55,7 @@ obj-$(CONFIG_PWM_RENESAS_RZG2L_GPT)	+= pwm-rzg2l-gpt.o
>   obj-$(CONFIG_PWM_RENESAS_RZ_MTU3)	+= pwm-rz-mtu3.o
>   obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
>   obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
> +obj-$(CONFIG_PWM_ROCKCHIP_V4)	+= pwm-rockchip-v4.o
>   obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
>   obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
>   obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
> diff --git a/drivers/pwm/pwm-rockchip-v4.c b/drivers/pwm/pwm-rockchip-v4.c
> new file mode 100644
> index 000000000000..7afa83f12b6a
> --- /dev/null
> +++ b/drivers/pwm/pwm-rockchip-v4.c
> @@ -0,0 +1,353 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Collabora Ltd.
> + *
> + * A Pulse-Width-Modulation (PWM) generator driver for the generators found in
> + * Rockchip SoCs such as the RK3576, internally referred to as "PWM v4". Uses
> + * the MFPWM infrastructure to guarantee exclusive use over the device without
> + * other functions of the device from different drivers interfering with its
> + * operation while it's active.
> + *
> + * Technical Reference Manual: Chapter 31 of the RK3506 TRM Part 1, a SoC which
> + * uses the same PWM hardware and has a publicly available TRM.
> + * https://opensource.rock-chips.com/images/3/36/Rockchip_RK3506_TRM_Part_1_V1.2-20250811.pdf
> + *
> + * Authors:
> + *     Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> + *
> + * Limitations:
> + * - When the output is disabled, it will end abruptly without letting the
> + *   current period complete.
> + *   TODO: This can be fixed in the driver in the future by having the enable-
> + *         to-disable transition switch to oneshot mode with one repetition,
> + *         and then disable the pwmclk and release mfpwm when the oneshot
> + *         complete interrupt fires.
> + * - When the output is disabled, the pin will remain driven to whatever state
> + *   it last had.
> + * - Adjustments to the duty cycle will only take effect during the next period.
> + * - Adjustments to the period length will only take effect during the next
> + *   period.
> + * - offset should be between 0 and (period - duty)
> + */
> +
> +#include <linux/math64.h>
> +#include <linux/mfd/rockchip-mfpwm.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +
> +struct rockchip_pwm_v4 {
> +	struct rockchip_mfpwm_func *pwmf;
> +	struct pwm_chip chip;
> +};
> +
> +struct rockchip_pwm_v4_wf {
> +	u32 period;
> +	u32 duty;
> +	u32 offset;
> +	u8 enable;
> +};
> +

...

> +
> +static int rockchip_pwm_v4_read_wf(struct pwm_chip *chip, struct pwm_device *pwm,
> +				   void *_wfhw)
> +{
> +	struct rockchip_pwm_v4 *pc = to_rockchip_pwm_v4(chip);
> +	struct rockchip_pwm_v4_wf *wfhw = _wfhw;
> +	int ret = 0;
> +

Redundant blank lin. ;-)

> +
> +	ret = mfpwm_acquire(pc->pwmf);
> +	if (ret)
> +		return ret;
> +
> +	wfhw->period = mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_PERIOD);
> +	wfhw->duty = mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_DUTY);
> +	wfhw->offset = mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_OFFSET);
> +	wfhw->enable = mfpwm_reg_read(pc->pwmf->base, PWMV4_REG_ENABLE) & PWMV4_EN_BOTH_MASK;
> +
> +	mfpwm_release(pc->pwmf);
> +
> +	return 0;
> +}
> +

...

> +MODULE_AUTHOR("Nicolas Frattaroli <nicolas.frattaroli@collabora.com>");
> +MODULE_DESCRIPTION("Rockchip PWMv4 Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("ROCKCHIP_MFPWM");
> +MODULE_ALIAS("platform:pwm-rockchip-v4");
> 

Tested-by: Damon Ding <damon.ding@rock-chips.com>

I have tested all the PWM channels in continuous mode on my 
RK3576-IOTEST board.

Test commands are like:

cd /sys/class/pwm/pwmchip0/
echo 0 > export
cd pwm0
echo 10000 > period
echo 5000 > duty_cycle
echo normal > polarity
echo 1 > enable

In addition, the patch related to DTS are attached.

Best regards,
Damon

--------------PdXS0cE3u8xAHvhAPnkRnp4J
Content-Type: text/plain; charset=UTF-8;
 name="rk3576_evb1_enable_all_pwm_channels.patch"
Content-Disposition: attachment;
 filename="rk3576_evb1_enable_all_pwm_channels.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvcm9ja2NoaXAvcmszNTc2LWV2YjEt
djEwLmR0cyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcm9ja2NoaXAvcmszNTc2LWV2YjEtdjEw
LmR0cwppbmRleCBkYjhmZWY3YTRmMWIuLmI4ZGI2ZTRjMTI0NiAxMDA2NDQKLS0tIGEvYXJj
aC9hcm02NC9ib290L2R0cy9yb2NrY2hpcC9yazM1NzYtZXZiMS12MTAuZHRzCisrKyBiL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvcm9ja2NoaXAvcmszNTc2LWV2YjEtdjEwLmR0cwpAQCAtMjQs
NiArMjQsNyBAQCBhbGlhc2VzIHsKIAogCWNob3NlbjogY2hvc2VuIHsKIAkJc3Rkb3V0LXBh
dGggPSAic2VyaWFsMDoxNTAwMDAwbjgiOworCQlib290YXJncyA9ICJyb290PVBBUlRVVUlE
PTYxNGUwMDAwLTAwMDAgcm9vdHdhaXQiOwogCX07CiAKIAlhZGNfa2V5czogYWRjLWtleXMg
ewpAQCAtOTQxLDMgKzk0Miw4MyBAQCB2cDBfb3V0X2hkbWk6IGVuZHBvaW50QFJPQ0tDSElQ
X1ZPUDJfRVBfSERNSTAgewogCQlyZW1vdGUtZW5kcG9pbnQgPSA8JmhkbWlfaW5fdnAwPjsK
IAl9OwogfTsKKworJnB3bTBfMmNoXzAgeworCXN0YXR1cyA9ICJva2F5IjsKKwlwaW5jdHJs
LTAgPSA8JnB3bTBtMV9jaDA+OworfTsKKworJnB3bTBfMmNoXzEgeworCXN0YXR1cyA9ICJv
a2F5IjsKKwlwaW5jdHJsLTAgPSA8JnB3bTBtMl9jaDE+OworfTsKKworJnB3bTFfNmNoXzAg
eworCXN0YXR1cyA9ICJva2F5IjsKKwlwaW5jdHJsLTAgPSA8JnB3bTFtMV9jaDA+OworfTsK
KworJnB3bTFfNmNoXzEgeworCXN0YXR1cyA9ICJva2F5IjsKKwlwaW5jdHJsLTAgPSA8JnB3
bTFtMV9jaDE+OworfTsKKworJnB3bTFfNmNoXzIgeworCXN0YXR1cyA9ICJva2F5IjsKKwlw
aW5jdHJsLTAgPSA8JnB3bTFtMl9jaDI+OworfTsKKworJnB3bTFfNmNoXzMgeworCXN0YXR1
cyA9ICJva2F5IjsKKwlwaW5jdHJsLTAgPSA8JnB3bTFtMV9jaDM+OworfTsKKworJnB3bTFf
NmNoXzQgeworCXN0YXR1cyA9ICJva2F5IjsKKwlwaW5jdHJsLTAgPSA8JnB3bTFtMV9jaDQ+
OworfTsKKworJnB3bTFfNmNoXzUgeworCXN0YXR1cyA9ICJva2F5IjsKKwlwaW5jdHJsLTAg
PSA8JnB3bTFtMV9jaDU+OworfTsKKworJnB3bTJfOGNoXzAgeworCXN0YXR1cyA9ICJva2F5
IjsKKwlwaW5jdHJsLTAgPSA8JnB3bTJtMV9jaDA+OworfTsKKworJnB3bTJfOGNoXzEgewor
CXN0YXR1cyA9ICJva2F5IjsKKwlwaW5jdHJsLTAgPSA8JnB3bTJtMV9jaDE+OworfTsKKwor
JnB3bTJfOGNoXzIgeworCXN0YXR1cyA9ICJva2F5IjsKKwlwaW5jdHJsLTAgPSA8JnB3bTJt
MV9jaDI+OworfTsKKworJnB3bTJfOGNoXzMgeworCXN0YXR1cyA9ICJva2F5IjsKKwlwaW5j
dHJsLTAgPSA8JnB3bTJtMV9jaDM+OworfTsKKworJnB3bTJfOGNoXzQgeworCXN0YXR1cyA9
ICJva2F5IjsKKwlwaW5jdHJsLTAgPSA8JnB3bTJtMV9jaDQ+OworfTsKKworJnB3bTJfOGNo
XzUgeworCXN0YXR1cyA9ICJva2F5IjsKKwlwaW5jdHJsLTAgPSA8JnB3bTJtMV9jaDU+Owor
fTsKKworJnB3bTJfOGNoXzYgeworCXN0YXR1cyA9ICJva2F5IjsKKwlwaW5jdHJsLTAgPSA8
JnB3bTJtMl9jaDY+OworfTsKKworJnB3bTJfOGNoXzcgeworCXN0YXR1cyA9ICJva2F5IjsK
KwlwaW5jdHJsLTAgPSA8JnB3bTJtMl9jaDc+OworfTsK

--------------PdXS0cE3u8xAHvhAPnkRnp4J--

