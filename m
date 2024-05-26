Return-Path: <linux-pwm+bounces-2238-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C738CF4F1
	for <lists+linux-pwm@lfdr.de>; Sun, 26 May 2024 18:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C37BE1C2095D
	for <lists+linux-pwm@lfdr.de>; Sun, 26 May 2024 16:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA9D1A28D;
	Sun, 26 May 2024 16:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.de header.i=@kloenk.de header.b="uPMbV/H6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA70C3C38;
	Sun, 26 May 2024 16:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716742593; cv=none; b=DX5b9d88mX4qSmA91Fx5pU7o3Pv2TZ5VHOi+qXcbr6sfDKhbvYLjCfy2V//59VssIYZvw8p5EcmAR7POjJFpUHQg4h/c7in+WDPclpuWM9l6dpG+wAGYRZQ7hxbo1CrtsGhrizrme/aNF44aQaPb7fAYeVDxSj6NhMdrl5hVWpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716742593; c=relaxed/simple;
	bh=X78jjsQ86RXdbowtYihaJzb8GQKZmbw2ydyhdKGXZFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bmoy9sV2NMxmBbYMgXf1x0Dx86jTTLInGxAtMOum05rx1hiQ+TL6v1waOyGtwjwHI6VVxLsHl9PK2PwAwgSOAOMXbW7ndku82wAOq/AtYmF/qaR9/mXCt2nbJ+bptZ9Ff0IAjLwCGPX29jZ7LpyIwxLNsSsWKEZi1G9iMlzJlKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.de; spf=pass smtp.mailfrom=kloenk.de; dkim=pass (1024-bit key) header.d=kloenk.de header.i=@kloenk.de header.b=uPMbV/H6; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.de
From: Finn Behrens <me@kloenk.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.de; s=mail;
	t=1716742586; bh=uY51i8VK4saPxA1AoHhLDzBJkgaIKcf7BimO7Tpr5fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uPMbV/H62AgvcaVgLEls2QddpD5MEtvsQ9hbiFEkv2GTSN+Rju98JG05WpUEojP0Q
	 i52cLoKM+ywo8d5Em5WJb32zOr31DZiTnKEvXTR71WcL8U2RnnzfnHX3fgnDYwx6nv
	 YnxO3GcMGe4rlUMnPkEQZ/zyfVS1fIg7l0DQ+/sk=
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, linux-pwm@vger.kernel.org,
 linux-gpio@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Heisath <jannis@imserv.org>, Yureka Lilian <yuka@yuka.dev>
Subject: Re: [PATCH] gpio-mvebu: no hardcoded timer assignment for pwm
Date: Sun, 26 May 2024 18:56:25 +0200
Message-ID: <224E981B-57DD-4C8F-BA37-F55ECB0F2CB6@kloenk.de>
In-Reply-To: <6chccjdn3yidi7rodcledxx7czt3adjxvaeeneii5ghfiw4oc3@t5qtmnlasvlo>
References: <20240130105515.30258-1-me@kloenk.de>
 <6chccjdn3yidi7rodcledxx7czt3adjxvaeeneii5ghfiw4oc3@t5qtmnlasvlo>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry for taking so so long, life happened.
Currently working on a v2 but maybe reasonable to discuss some things alr=
eady here.

(And sorry for first sending html, to long not worked on kernel and trust=
 my mail client to much, so second resend without html)

> On 8. Feb 2024, at 09:05, Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengut=
ronix.de> wrote:
>
> Hello,
>
> On Tue, Jan 30, 2024 at 11:55:13AM +0100, Finn Behrens wrote:
>> Removes the hardcoded timer assignment of timers to pwm controllers.
>> This allows to use more than one pwm per gpio bank.
>>
>> Original patch with chip_data interface by Heisath <jannis@imserv.org =
<mailto:jannis@imserv.org>>
>>
>> Link: https://wiki.kobol.io/helios4/pwm/#patch-requirement
>> Co-developed-by: Yureka Lilian <yuka@yuka.dev <mailto:yuka@yuka.dev>>
>> Signed-off-by: Yureka Lilian <yuka@yuka.dev <mailto:yuka@yuka.dev>>
>> Signed-off-by: Finn Behrens <me@kloenk.de <mailto:me@kloenk.de>>
>
> I find this patch hard to understand and I hope it's more complicated
> than it could be. I wonder if it would be beneficial to split this patc=
h
> in two. In the first patch just introduce the new structures with all
> the necessary renaming and only in the second patch implement the added=

> flexibility.
I will try for the v2, currently not sure how easy that will be as most t=
hings are used directly and will not work when not used.
But might have to rewrite quite a bit as think I found a possible race co=
ndition in this patch. (further down below with the static variable)
>
> Some more details below.
>
>> drivers/gpio/gpio-mvebu.c | 223 ++++++++++++++++++++++++--------------=

>> 1 file changed, 139 insertions(+), 84 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
>> index a13f3c18ccd4..303ea3be0b69 100644
>> --- a/drivers/gpio/gpio-mvebu.c
>> +++ b/drivers/gpio/gpio-mvebu.c
>> @@ -94,21 +94,43 @@
>>
>> #define MVEBU_MAX_GPIO_PER_BANK		32
>>
>> -struct mvebu_pwm {
>> +enum mvebu_pwm_ctrl {
>> +	MVEBU_PWM_CTRL_SET_A =3D 0,
>> +	MVEBU_PWM_CTRL_SET_B,
>> +	MVEBU_PWM_CTRL_MAX
>> +};
>> +
>> +struct mvebu_pwmchip {
>> 	struct regmap		*regs;
>> 	u32			 offset;
>> 	unsigned long		 clk_rate;
>> -	struct gpio_desc	*gpiod;
>> -	struct pwm_chip		 chip;
>> 	spinlock_t		 lock;
>> -	struct mvebu_gpio_chip	*mvchip;
>> +	bool			 in_use;
>>
>> 	/* Used to preserve GPIO/PWM registers across suspend/resume */
>> -	u32			 blink_select;
>> 	u32			 blink_on_duration;
>> 	u32			 blink_off_duration;
>> };
>>
>> +struct mvebu_pwm_chip_drv {
>> +	enum mvebu_pwm_ctrl	 ctrl;
>> +	struct gpio_desc	*gpiod;
>> +	bool			 master;
>> +};
>> +
>> +struct mvebu_pwm {
>> +	struct pwm_chip		 chip;
>> +	struct mvebu_gpio_chip	*mvchip;
>> +	struct mvebu_pwmchip	 controller;
>> +	enum mvebu_pwm_ctrl	 default_controller;
>> +
>> +	/* Used to preserve GPIO/PWM registers across suspend/resume */
>> +	u32				 blink_select;
>> +	struct mvebu_pwm_chip_drv	 drv[];
>> +};
>
> So we have three different structures related to pwm. Some highlevel
> description (in a comment or at least the commit log) about how the
> hardware works and which struct describes what would be helpful. I gave=

> up after 15 min of reading this patch and trying to understand it.
>
>> +static struct mvebu_pwmchip  *mvebu_pwm_list[MVEBU_PWM_CTRL_MAX];
>
> Huh, a static variable. Does that mean we can only have one mvebu_gpio
> device?
This is the global over the gpio aliases gpio0 and gpio1.
As far as I understand this we take the id from the alias in the probe fu=
nction and there we can only ever have the id 0 and 1.

While looking over this again I noticed that we therefore don=E2=80=99t h=
ave a working lock with this, and now gpio0 can take the pwm from gpio1 w=
hich is the main idea behind this patch.
My idea would be convert the lock from the pwm chip to a global lock in t=
his module and use that for all pwm locks and this global list. I don=E2=80=
=99t know if there is a less global variable that we can access from both=
 gpio0 and gpio1?
>
>> +
>> struct mvebu_gpio_chip {
>> 	struct gpio_chip   chip;
>> 	struct regmap     *regs;
>> @@ -285,12 +307,12 @@ mvebu_gpio_write_level_mask(struct mvebu_gpio_ch=
ip *mvchip, u32 val)
>>  * Functions returning offsets of individual registers for a given
>>  * PWM controller.
>>  */
>> -static unsigned int mvebu_pwmreg_blink_on_duration(struct mvebu_pwm *=
mvpwm)
>> +static unsigned int mvebu_pwmreg_blink_on_duration(struct mvebu_pwmch=
ip *mvpwm)
>
> I'm a fan of picking always the same variable name for the same thing
> and different names for different things. "mvpwm" is used for variables=

> of type struct mvebu_pwmchip and struct mvebu_pwm.
>
>> {
>> 	return mvpwm->offset + PWM_BLINK_ON_DURATION_OFF;
>> }
>
> Best regards
> Uwe
>
> -- =

> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig     =
       |
> Industrial Linux Solutions                 | https://www.pengutronix.de=
/ |


