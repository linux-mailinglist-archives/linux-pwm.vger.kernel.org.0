Return-Path: <linux-pwm+bounces-5996-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B67AB7F12
	for <lists+linux-pwm@lfdr.de>; Thu, 15 May 2025 09:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8BF866C36
	for <lists+linux-pwm@lfdr.de>; Thu, 15 May 2025 07:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A34A27A461;
	Thu, 15 May 2025 07:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AlV76Kx0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EAA2222CB;
	Thu, 15 May 2025 07:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747295056; cv=none; b=QAjDw18rKaL8PzIvUaRdntJNZV26OPFJSrpPdm1iASR29yYKsF/IvxqT9bA1xYI0UeZHuneM3mcFEPTqE4PqUROd50pWx1AoHixHsuRx3upjb2k6yadNtLZm+m5RsQvuxtToDPmLvdSF8lSC9P5eB16uT/89DeGQDFFy4XYGDeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747295056; c=relaxed/simple;
	bh=Mlac3xE6wcJ6Jis+XaIwCBuS6dH+sSkuAxiSfCJzkyE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=fYeMTBiP5PGEraP7h+x2TkKJABu5f4ZJV6vC+NuZFUaUVmAP73oCllaPY/d6ZmOm5RK3jA0AzXkrJEwO49OiVTiERYtaJ0X0pEhotYVJb/bg4/iBwy35LpTV3vOIE71WsmwQXCqOMH0d8vD+flH7VxRwARRJgDh+MKTLtKlmt5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AlV76Kx0; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id F09A65864E1;
	Thu, 15 May 2025 07:14:51 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A1C3443B4A;
	Thu, 15 May 2025 07:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747293283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0mX1woD7s+wGWYgmpuE+SHHxupgRU2OvGk0U0nEWZuU=;
	b=AlV76Kx09zhkdC+dl4JnfmpX3qVYdHqlFCoLbANvcSm/AwUsqVCN4fZyCRYM4tnAwm8Io1
	+ioDLSdbJ1b8AjppXGYfaxY5cYFfZdCdRMlKgZgPZcF5UgMh/0Ev4F8UWJoBhMBMANddB/
	3wqWNTExt4MaZlpmg9MZtpzUzqDXhGbeb/NhpcKowlwppTQr8q7xBXFD3VUZAUdXUUNCAw
	DRHvrvfGki6dVG6SdbbpkQKheIC2bOdtogIUWy4op/bmuWO64M3YeEgYNb/mYCq2efiuSU
	tAFMWlbAd8mDhcn1zBfIXz07+8pB2JnxO36YrPMlRpz6WcvqDP5gZC0fv6DNig==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 May 2025 09:14:40 +0200
Message-Id: <D9WJRVV500O3.GUV0MKHRGTH2@bootlin.com>
Subject: Re: [PATCH v8 04/11] pwm: max7360: Add MAX7360 PWM support
Cc: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Kamel Bouhara" <kamel.bouhara@bootlin.com>, "Linus
 Walleij" <linus.walleij@linaro.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, "Michael Walle"
 <mwalle@kernel.org>, "Mark Brown" <broonie@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <andriy.shevchenko@intel.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250509-mdb-max7360-support-v8-0-bbe486f6bcb7@bootlin.com>
 <20250509-mdb-max7360-support-v8-4-bbe486f6bcb7@bootlin.com>
 <5eb7xqo7bfzath3xy7i6v5fep7qwfeg4z3rtzifmgnyvlc3o5b@yi6hzur52hl3>
In-Reply-To: <5eb7xqo7bfzath3xy7i6v5fep7qwfeg4z3rtzifmgnyvlc3o5b@yi6hzur52hl3>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdelvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekhfekieeftefhjeetveefudehuddvvdeuvddvudfgfffhveekffethfeuffdtudenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtdegmegtvggttdemfhdthegsmegtvdgsmeduvggvudemrgelfhekmeefiegrmeguheegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtgeemtggvtgdtmehftdehsgemtgdvsgemudgvvgdumegrlehfkeemfeeirgemugehgeekpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopehukhhlvghinhgvkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhto
 heprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Tue May 13, 2025 at 12:08 PM CEST, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>
> On Fri, May 09, 2025 at 11:14:38AM +0200, mathieu.dubois-briand@bootlin.c=
om wrote:
>> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
>>=20
>> Add driver for Maxim Integrated MAX7360 PWM controller, supporting up to
>> 8 independent PWM outputs.
>>=20
>> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
>> Co-developed-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.co=
m>
>> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
>> ---
>>  drivers/pwm/Kconfig       |  10 +++
>>  drivers/pwm/Makefile      |   1 +
>>  drivers/pwm/pwm-max7360.c | 186 +++++++++++++++++++++++++++++++++++++++=
+++++++
>>  3 files changed, 197 insertions(+)
>>=20
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 4731d5b90d7e..0b22141cbf85 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -755,4 +755,14 @@ config PWM_XILINX
>>  	  To compile this driver as a module, choose M here: the module
>>  	  will be called pwm-xilinx.
>> =20
>> +config PWM_MAX7360
>> +	tristate "MAX7360 PWMs"
>> +	depends on MFD_MAX7360
>> +	help
>> +	  PWM driver for Maxim Integrated MAX7360 multifunction device, with
>> +	  support for up to 8 PWM outputs.
>> +
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called pwm-max7360.
>> +
>>  endif
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index 539e0def3f82..9c7701d8070b 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -36,6 +36,7 @@ obj-$(CONFIG_PWM_LPC32XX)	+=3D pwm-lpc32xx.o
>>  obj-$(CONFIG_PWM_LPSS)		+=3D pwm-lpss.o
>>  obj-$(CONFIG_PWM_LPSS_PCI)	+=3D pwm-lpss-pci.o
>>  obj-$(CONFIG_PWM_LPSS_PLATFORM)	+=3D pwm-lpss-platform.o
>> +obj-$(CONFIG_PWM_MAX7360)	+=3D pwm-max7360.o
>>  obj-$(CONFIG_PWM_MESON)		+=3D pwm-meson.o
>>  obj-$(CONFIG_PWM_MEDIATEK)	+=3D pwm-mediatek.o
>>  obj-$(CONFIG_PWM_MICROCHIP_CORE)	+=3D pwm-microchip-core.o
>> diff --git a/drivers/pwm/pwm-max7360.c b/drivers/pwm/pwm-max7360.c
>> new file mode 100644
>> index 000000000000..af2006ec7a96
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-max7360.c
>> @@ -0,0 +1,186 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright 2025 Bootlin
>> + *
>> + * Author: Kamel BOUHARA <kamel.bouhara@bootlin.com>
>> + * Author: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
>> + *
>> + * Limitations:
>> + * - Only supports normal polarity.
>> + * - The period is fixed to 2 ms.
>> + * - Only the duty cycle can be changed, new values are applied at the =
beginning
>> + *   of the next cycle.
>> + * - When disabled, the output is put in Hi-Z.
>> + */
>> +#include <linux/bits.h>
>> +#include <linux/dev_printk.h>
>> +#include <linux/err.h>
>> +#include <linux/math64.h>
>> +#include <linux/mfd/max7360.h>
>> +#include <linux/minmax.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pwm.h>
>> +#include <linux/regmap.h>
>> +#include <linux/time.h>
>> +#include <linux/types.h>
>> +
>> +#define MAX7360_NUM_PWMS			8
>> +#define MAX7360_PWM_MAX_RES			255
>> +#define MAX7360_PWM_PERIOD_NS			(2 * NSEC_PER_MSEC)
>> +
>> +struct max7360_pwm_waveform {
>> +	u8 duty_steps;
>> +	bool enabled;
>> +};
>> +
>> +static int max7360_pwm_request(struct pwm_chip *chip, struct pwm_device=
 *pwm)
>> +{
>> +	struct regmap *regmap =3D pwmchip_get_drvdata(chip);
>> +	int ret;
>> +
>> +	ret =3D regmap_write_bits(regmap, MAX7360_REG_PWMCFG(pwm->hwpwm),
>> +				MAX7360_PORT_CFG_COMMON_PWM, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return regmap_write_bits(regmap, MAX7360_REG_PORTS, BIT(pwm->hwpwm), B=
IT(pwm->hwpwm));
>
> What is the effect of these writes? It doesn't need to be undone in a
> matching .free()?
>

The first one (MAX7360_PORT_CFG_COMMON_PWM) asks to use a specific duty
cycle for this PWM output and not a value shared across all PWMs. I
believe this one have no reason to be ever reverted.

About the second one, it does switch the output value. Reading the
datasheet, it's not clear if and why setting this here is required. I
will make some tests on the hardware a bit later this week. Still, I
believe there is no need to revert it later.

>> +}
>> +
>> +static int max7360_pwm_round_waveform_tohw(struct pwm_chip *chip,
>> +					   struct pwm_device *pwm,
>> +					   const struct pwm_waveform *wf,
>> +					   void *_wfhw)
>> +{
>> +	struct max7360_pwm_waveform *wfhw =3D _wfhw;
>> +	u64 duty_steps;
>> +
>> +	/*
>> +	 * Ignore user provided values for period_length_ns and duty_offset_ns=
:
>> +	 * we only support fixed period of MAX7360_PWM_PERIOD_NS and offset of=
 0.
>> +	 */
>> +	duty_steps =3D mul_u64_u64_div_u64(wf->duty_length_ns, MAX7360_PWM_MAX=
_RES,
>> +					 MAX7360_PWM_PERIOD_NS);
>> +
>> +	wfhw->duty_steps =3D min(MAX7360_PWM_MAX_RES, duty_steps);
>> +	wfhw->enabled =3D !!wf->duty_length_ns;
>> +
>> +	return 0;
>> +}
>> +
>> +static int max7360_pwm_round_waveform_fromhw(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>> +					     const void *_wfhw, struct pwm_waveform *wf)
>> +{
>> +	const struct max7360_pwm_waveform *wfhw =3D _wfhw;
>> +
>> +	wf->period_length_ns =3D wfhw->enabled ? MAX7360_PWM_PERIOD_NS : 0;
>> +	wf->duty_offset_ns =3D 0;
>> +	wf->duty_length_ns =3D DIV_ROUND_UP(wfhw->duty_steps * MAX7360_PWM_PER=
IOD_NS,
>> +					  MAX7360_PWM_MAX_RES);
>> +
>> +	return 0;
>> +}
>> +
>> +static int max7360_pwm_write_waveform(struct pwm_chip *chip,
>> +				      struct pwm_device *pwm,
>> +				      const void *_wfhw)
>> +{
>> +	struct regmap *regmap =3D pwmchip_get_drvdata(chip);
>> +	const struct max7360_pwm_waveform *wfhw =3D _wfhw;
>> +	unsigned int val;
>> +	int ret;
>> +
>> +	val =3D wfhw->enabled ? BIT(pwm->hwpwm) : 0;
>> +	ret =3D regmap_write_bits(regmap, MAX7360_REG_GPIOCTRL, BIT(pwm->hwpwm=
), val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (wfhw->duty_steps)
>> +		return regmap_write(regmap, MAX7360_REG_PWM(pwm->hwpwm), wfhw->duty_s=
teps);
>
> Would it make sense to first write duty_steps and only then enable?
> Otherwise it might happen that you enable and still have a wrong duty
> configuration in the MAX7360_REG_PWM register and emit a wrong period?
>

Yes, I believe it does make sense: I will try to invert them.

> Do you need to write duty_steps =3D 0 if enabled is false?
>

No, this is not needed: output will be in hi-Z mode. As we have
"wfhw->enabled =3D !!wf->duty_length_ns", this should be correct here. But
reading this, I believe I could modify above code to be more clear with:

if (wfhw->enabled)
	return regmap_write(regmap, MAX7360_REG_PWM(pwm->hwpwm), wfhw->duty_steps)=
;


>> +	return 0;
>> +}
>
> Best regards
> Uwe




--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


