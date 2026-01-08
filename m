Return-Path: <linux-pwm+bounces-7874-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B269D01461
	for <lists+linux-pwm@lfdr.de>; Thu, 08 Jan 2026 07:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E7403000189
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Jan 2026 06:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD53F33E369;
	Thu,  8 Jan 2026 06:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="e5KrIPDz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F1225F99F;
	Thu,  8 Jan 2026 06:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767854662; cv=none; b=cXf4JXXRP0LGK0HHEVPgPrMkS3trBupIm/aWNc1oAjFjlIfF5KgBW92lR3JgX1UJgDFHB4N2rF+QDHtmZCorPk25Hk/npvB4Jht0V/Ce+mel9FQtHmsg0/7HgRv7aPA0jYCyD2QdM4IR1FNgoy+s92lWckcan/UMvbDqQQcFNI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767854662; c=relaxed/simple;
	bh=YoLFn32Xw+uftb+RucH5H8d09ERQBdftmuXlOIqVMpA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PTq0Dmc5HF7+EpyI65DohuYhkQoRRnS8OWlU+mdSgxNEycM0hHJ+X7JiolrI4S8AT7tAh3fgm6F63R51Fq3jM6fTD7pFA6KjcTA2gIqtUhqnaH7cK6NroyuRPVbCvAXF1jB2iQ8fGOMUi0knsaIXk2OYSO8eHpr3HLztm4J2A0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=e5KrIPDz; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail2; t=1767854649; x=1768113849;
	bh=JvbqfdE84s/Q3OOhKk+KWzNYUT7BCFUTKaN5MZ+iwW8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=e5KrIPDzjg1eSWFaPCAMJbQZi9QV6uXXbAp8JUNHoExGxRVbZYfPic5fG1Stk+ety
	 UglMdcOOJzCoJhMUgZm9hviKfZl3fGbI9RWfijo6ADEua7tzieJTcJ1tEbJcQUAzWH
	 EkQlM+nAIari9yZuVeKSy6NK1iDvyruNab0gvzuqy+QJiQknsoen5KM5UmFhnc5oPh
	 CugkPCSuozE+CMdPaeCodhQ4SfuqaPLyya41H1JmE0W7kDRrhYFAX8uOLS2JarTlBF
	 xV1cyBCoyVEQbwNblQZBlFLihg+w/3mJAMR61vodMHj/+FsiTqZIjZZVXH+ju+oUtf
	 Aw5U8tsJUWdKA==
Date: Thu, 08 Jan 2026 06:44:06 +0000
To: =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
From: Sean Nyekjaer <sean@geanix.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] pwm: stm32: handle polarity change when PWM is enabled
Message-ID: <paj3uf6apunonvfz2w2anqmddivjrofmfo5wktygz4r6l7diqf@7gen7gjgyuar>
In-Reply-To: <zj2vpruzoeyvyyzxiqcffajyhpmem4q75l6gzgxd4jgaizhrdq@bxuudn4kyvr3>
References: <20260106-stm32-pwm-v1-1-33e9e8a9fc33@geanix.com> <kemjjoyrhqglqq4p2j6kygspevq2mdbiujtnksw4rkdapoqcfy@zte2c7fhqvn3> <2e2iahbzcepbzwgk7xeta2afxmycfjgv2zofzngqjvp4on46r2@mzpi4bz4uqie> <nwhixocvhii27jvcyg7ex5emewntgfhyxa4ds5vo2dphe7xfe4@ibjsjdd5fgmn> <fwaodg2ovh7j47ifwjhgeppxs3oiqht5ecbs7bmfbi7j6djejs@shwokpcmutr3> <zj2vpruzoeyvyyzxiqcffajyhpmem4q75l6gzgxd4jgaizhrdq@bxuudn4kyvr3>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: 014263d0e98d319b81f8ce02eec1a63633eddc36
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Thu, Jan 08, 2026 at 07:05:15AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Jan 07, 2026 at 04:05:56PM +0000, Sean Nyekjaer wrote:
> > On Wed, Jan 07, 2026 at 04:54:46PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Tue, Jan 06, 2026 at 11:30:34AM +0000, Sean Nyekjaer wrote:
> > > > On Tue, Jan 06, 2026 at 11:22:57AM +0100, Uwe Kleine-K=C3=B6nig wro=
te:
> > > > > On Tue, Jan 06, 2026 at 08:01:57AM +0100, Sean Nyekjaer wrote:
> > > > > > After commit 7346e7a058a2 ("pwm: stm32: Always do lazy disablin=
g"),
> > > > > > polarity changes are ignored. Updates to the TIMx_CCER CCxP bit=
s are
> > > > > > ignored by the hardware when the master output is enabled via t=
he
> > > > > > TIMx_BDTR MOE bit.
> > > > > [...]
> > > > > I have hardware using this driver, will set it up later this week=
 for
> > > > > testing.
> > > >=20
> > > > Very cool, looking forward to hear if you can re-produce.
> > >=20
> > > I cannot. I have:
> > >=20
> > > =09# uname -r
> > > =096.11.0-rc1-00028-geb18504ca5cf-dirty
> > >=20
> > > (the -dirty is only from enabling the pwm for my machine, no driver
> > > changes)
> > >=20
> > > =09# cat /sys/kernel/debug/pwm
> > > =090: platform/40001000.timer:pwm, 4 PWM devices
> > > =09...
> > > =09 pwm-3   (sysfs               ): requested enabled period: 313720 =
ns duty: 10000 ns polarity: normal
> > >=20
> > > and pulseview/sigrok detects 3.187251% with a period of 313.8 =C2=
=B5s.
> > >=20
> > > After
> > >=20
> > > =09echo inversed > /sys/class/pwm/pwmchip0/pwm3/polarity
> > >=20
> > > the output changes to
> > >=20
> > > =09# cat /sys/kernel/debug/pwm
> > > =090: platform/40001000.timer:pwm, 4 PWM devices
> > > =09...
> > > =09 pwm-3   (sysfs               ): requested enabled period: 313720 =
ns duty: 10000 ns polarity: inverse
> > >=20
> > > and pulseview/sigrok claims 96.812749% with a period of 313.8 =C2=
=B5s.
> > > So the polarity change happend as expected.
> > >=20
> > > This is on an st,stm32mp135f-dk board.
> > >=20
> > > Where is the difference to your observations?
> > >=20
> >=20
> > Thanks for taking a look!
> > I'm using the PWM for a backlight. With this [0] in my dts:
> >=20
> > [0]:
> > =09backlight: backlight {
> > =09=09compatible =3D "pwm-backlight";
> > =09=09pwms =3D <&pwm4 0 125000 PWM_POLARITY_INVERTED>;
> > =09=09brightness-levels =3D <102 235 255>;
> > =09=09default-brightness-level =3D <80>;
> > =09=09num-interpolated-steps =3D <100>;
> > =09=09enable-gpios =3D <&gpiof 12 GPIO_ACTIVE_LOW>;
> > =09status =3D "okay";
> > =09};
> >=20
> > Maybe that is doing something differently.
>=20
> What is the actual problem you have? I assume it's the backlight being
> off after boot? Does it start working if you disable and reenable?

Yes, no backlight at default brightness. But the range is inverted so a low=
 brightness
setting i get maximum brightness.
No, it never enters stm32_pwm_set_polarity().

>=20
> Can you please boot with
>=20
> =09trace_event=3Dpwm
>=20
> on the command line and provide /sys/kernel/debug/tracing/trace from
> after the problem happend?

Tracing output is the same before and after this patch:
# tracer: nop
#
# entries-in-buffer/entries-written: 2/2   #P:2
#
#                                _-----=3D> irqs-off/BH-disabled
#                               / _----=3D> need-resched
#                              | / _---=3D> hardirq/softirq
#                              || / _--=3D> preempt-depth
#                              ||| / _-=3D> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
    kworker/u5:0-24      [000] .....     1.867389: pwm_apply: 482f1c0e: per=
iod=3D125000 duty_cycle=3D0 polarity=3D1 enabled=3D0 err=3D0
     kworker/1:0-22      [001] .....     1.984044: pwm_apply: 482f1c0e: per=
iod=3D125000 duty_cycle=3D101960 polarity=3D1 enabled=3D1 err=3D0

I have added this diff to the kernel to show what happens:
diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 67414b97ef4d..94f6d0f33365 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -394,6 +394,7 @@ static int stm32_pwm_set_polarity(struct stm32_pwm *pri=
v, int ch,
 {
 =09u32 mask;

+=09printk("stm32_pwm_set_polarity: %d\n", polarity);
 =09mask =3D TIM_CCER_CC1P << (ch * 4);
 =09if (priv->have_complementary_output)
 =09=09mask |=3D TIM_CCER_CC1NP << (ch * 4);
@@ -455,6 +456,7 @@ static int stm32_pwm_apply(struct pwm_chip *chip, struc=
t pwm_device *pwm,
 =09int ret;

 =09enabled =3D pwm->state.enabled;
+=09printk("stm32_pwm_apply: enabled %d, state->polarity %d, pwm->state.pol=
arity %d\n", enabled, state->polarity, pwm->state.polarity);

 =09if (!state->enabled) {
 =09=09if (enabled)

Before this patch:
root@localhost:~# journalctl -k | grep pwm
Jan 8 7:30:33 localhost kernel: stm32_pwm_apply: enabled 0, state->polarity=
 1, pwm->state.polarity 0
Jan 8 7:30:33 localhost kernel: stm32_pwm_apply: enabled 0, state->polarity=
 1, pwm->state.polarity 1

After this patch:
root@localhost:~# journalctl -k | grep pwm
Jan 8 7:38:33 localhost kernel: stm32_pwm_apply: enabled 0, state->polarity=
 1, pwm->state.polarity 0
Jan 8 7:38:33 localhost kernel: stm32_pwm_set_polarity: 1
Jan 8 7:38:33 localhost kernel: stm32_pwm_apply: enabled 0, state->polarity=
 1, pwm->state.polarity 1

I hope that clarifies things :)

/Sean


