Return-Path: <linux-pwm+bounces-9651-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3/kMNIhNT2rUdwIAu9opvQ
	(envelope-from <linux-pwm+bounces-9651-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 09:28:08 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0E872DB06
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 09:28:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=TVt7xgRP;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9651-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9651-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29A923035ABE
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2026 07:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606FB28466C;
	Thu,  9 Jul 2026 07:26:20 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D78D3C988E
	for <linux-pwm@vger.kernel.org>; Thu,  9 Jul 2026 07:26:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783581980; cv=pass; b=CVjAkgqBnMKwcrIGo4YbZ+WsKAT3BlzjrsJn+Xlms1IiXQFbkZgVb193tPa6ilv6nBpe7az6k1j8mNUyRU/3TZj1pLVDuI3ogww3WrQ+4dzuiR2PLB+1d+WqBSXkSzJk4plTnMi5dvhVrJYKqEnwIOvV9/f4y50i62Ph213zvCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783581980; c=relaxed/simple;
	bh=atm+PdMZl1wW0B9PRYBjvl0TgU7wVgqfSo6gBSDacKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VrN938v3aAyADJpeb0Q9ZD3D1/PhHZA/zIFFEoDAruuJwX5g85xAGVJMs88H8b/i/IkJMlrrFLOX24cnP1K9qVVNQ5TElTKFfwnFZ35xeDB4WlwwTuFVFTx+hhPvjtS7LQicIZWVTqYpiJM+jv0zuL755fJoqjHgXoy9hVh65jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVt7xgRP; arc=pass smtp.client-ip=209.85.167.47
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aeb8c19017so1560442e87.0
        for <linux-pwm@vger.kernel.org>; Thu, 09 Jul 2026 00:26:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783581977; cv=none;
        d=google.com; s=arc-20260327;
        b=bIJVHVyGqmk8vuTU4aRAcVJnc5eOmvQFtKHk1qEe3ToBza6i9KhAuD19SfuKU+VZ3V
         Ff2DR2WXSMFsWEPrIvaFcGEUAbVwyyQ/TXJ6uF2rNRYbLjGpJhcEo8an2LrbZsSKUBzB
         gH3icYnQhTdMLn39uhFai4mito6UUzyZvJCjFTzeBEpivVE7C67jBZj9J7Nr6okHwWHS
         7XwFvRQ5+C8bcDFxUjMxCb51n59UnmHAQmVXVHY03pWyp69M2QRiY71V2hg/E4Q0pt0b
         ahOc8lcZGU1c90oO/mbSha1FAEyeSTPXK/gFA0knTSs2Sv4gNHZFiZWFxLup2ZR6668J
         7H6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RKfQcGkaq73R9SJOhnc9GR7mrRhdzvak40FCluSHJsM=;
        fh=fgljPGkhB+22q0EGU55Ztey5Vdp7MybxgMklzUrVCb8=;
        b=o0Eps1U2kFxQuVmmklPYLCH7/BU+mfcS1nW3yOe3xfaDHtkfEmg/RbhDakMRjTToGT
         LBOT3SHXvv3fPJ47gMhYzIhXyvT7pD00AGDzl2oU9PC7rwCIWP3Dpo57O521V1mS6Ok5
         o6ugH4Jm90q0l2hI0MLw7UgDDWKNguTD0JYl2GLwPRoLHvxphF+ytX7dEzBK0NXE/wYy
         PrF40hNLwdayzMQ30RLqHcuzj/u/Kx99b1KoFO5/4XQShBNv3dlVrbF/gcAsVoFZru7u
         a2VABATUvdM41UaNzgQxaZN+zWuBTlvM3zJoKoWii0/wuQVhnnSfWlvg5BazJz1RLGbG
         qRUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783581977; x=1784186777; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RKfQcGkaq73R9SJOhnc9GR7mrRhdzvak40FCluSHJsM=;
        b=TVt7xgRPqm+jHZvblFAM3jPSNeHg4joDJojkGM62n/n+wdAnoLtIjf2rEOOZUZzTU1
         ZeNXhVbBo5WhMtcK2Zh2AlKjbLRO3vUNgiZU/07QbI9XNyCKrEvQ5H4l+BTVhlO5lwq8
         TydwjgBDr9qlf7lJ4+oFLgAWoFECxiEe0KWdHEOrCeA07CDnCnrdnmGUjyc6/v1dryTx
         ttehKy9b408bPHgXKuT3+1l79E3ds1omY8Nnlu10qfFZR5cr94u4o+FRXkIseSyn6P1e
         9+A5Fc76y2F+fzSZtFOZYpRJWOvjZeWau0t4LHt2DZxo/I/w1J2V2/RLoS60lboMRjT3
         KUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783581977; x=1784186777;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RKfQcGkaq73R9SJOhnc9GR7mrRhdzvak40FCluSHJsM=;
        b=VGlUZKD5RMqlQsHRBI2CLTzR77HRH+IhaG1s649xOBtFzP//6jhWxw9NDYl7MPSN38
         nQ5bNyQSC38pW09uVC0fFCRs3Z/tZf+tmoT6N2uTOFVoSklzZbVY2BiI/XPRMGoWptnT
         5OpdEu2SLO9lMGC4/XZVSnjHt3quw4d4dn1yFA0MGvNNSiFXET2e/xKMPv39NFEu+/iO
         7CcYFfuHCt722LMSk8lzoTkfrDPK96oJgaNCYRYzTWmHSwrG1advm9TTsgbogivN1PDO
         F8n2TeVT0K44/IUlYyofqk9uK7aGtdfqevAG3C04sniYeTRlwRqg8J8EPMok+hujHS0q
         RohA==
X-Forwarded-Encrypted: i=1; AHgh+RomUebYz8ShAEER8lHg5KpZ0L7KV1rQZ6TmctEukPnXIQ0MMR8JVsgV/nwyRRGOvuY/t1BvT4RcN68=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHLRnFMPYS16wgxowCJwA54ManfFSkHAcVWdUgvdSm3QdBiPX2
	FCe2YF29fj6jOo9ndij16FyY3XOSzSThJ+DjzRwh4bvu4BWuuY4CpyKbgiz4tQ/1NDCqdNmZWLn
	Jf70JPPnqVgZH5VjZI8yo2pWWqH3A+0M=
X-Gm-Gg: AfdE7ckrJtlsGE2XbWUaAKOcrbWKSxvqFNW4LdrVKkOhPthXWbVGcZgHtkECfYBlhui
	HaUCaVW3ZKPX39cwFc7ReqsEoxo45fFRHrAQgzotmaO97MjonIHBeJ6PIyjIF+FnADNd4KFuCae
	f0tm8NBBRFxb92DmgW8ztvurCDYakf6S+cJ6/p2X5+mcjnNmNYW3bj5WSQe/KLJW/2mHBHoGcYt
	ASrmmm5379PP8V7RjsukreSL1rx80neD/v4qLI2FDc/QJ7ju6O51nTzOdTVNDFIFj6uYD3gWTuQ
	YWKD9zk+MlezlPX43faZW9/5t41nfGJ74UbT6I+nJDdPpiCb0MSghjE+YnE=
X-Received: by 2002:a05:6512:8344:b0:5ae:adbb:43c2 with SMTP id
 2adb3069b0e04-5b01148629dmr1009622e87.33.1783581976467; Thu, 09 Jul 2026
 00:26:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626-pwm-loongson-fix-v2-0-5492db953879@gmail.com>
 <20260626-pwm-loongson-fix-v2-1-5492db953879@gmail.com> <aktdkn-NcQt7J1YS@monoceros>
In-Reply-To: <aktdkn-NcQt7J1YS@monoceros>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Thu, 9 Jul 2026 15:25:38 +0800
X-Gm-Features: AUfX_mw1L65BnLDzO4DEx0lLk4EBSXiuaFJGZAnZ_MP9FsBu2pBvYEQR8kYZzBo
Message-ID: <CAJhJPsVffZLTzXyA41rxm=A54sZhROVg-+K-gWo1KEzuKGv15w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pwm: loongson: Fix low pulse buffer register handling
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:zhoubinbin@loongson.cn,m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9651-lists,linux-pwm=lfdr.de];
	FORGED_SENDER(0.00)[keguangzhang@gmail.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[keguangzhang@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E0E872DB06

On Mon, Jul 6, 2026 at 4:00=E2=80=AFPM Uwe Kleine-K=C3=B6nig <ukleinek@kern=
el.org> wrote:
>
> Hello,
>
> On Fri, Jun 26, 2026 at 08:24:22PM +0800, Keguang Zhang via B4 Relay wrot=
e:
> > From: Keguang Zhang <keguang.zhang@gmail.com>
> >
> > The Loongson PWM register at offset 0x4 is documented as the Low
> > Pulse Buffer Register, which stores the low pulse width rather than
> > the duty cycle.
> >
> > However, this register was incorrectly defined and treated as a
> > duty-cycle register. As a result, the duty cycle and low pulse cycle
> > are swapped in the generated PWM waveform.
> >
> > Program the low pulse (period - duty) into the register and
> > adjust pwm_loongson_get_state() accordingly when reconstructing the
> > duty cycle.
> >
> > Fixes: 2b62c89448dd ("pwm: Add Loongson PWM controller support")
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
> >  drivers/pwm/pwm-loongson.c | 30 +++++++++++++++++-------------
> >  1 file changed, 17 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
> > index 31a57edecfd0..69514b5a1324 100644
> > --- a/drivers/pwm/pwm-loongson.c
> > +++ b/drivers/pwm/pwm-loongson.c
> > @@ -22,6 +22,7 @@
> >   */
> >
> >  #include <linux/acpi.h>
> > +#include <linux/bitfield.h>
> >  #include <linux/clk.h>
> >  #include <linux/device.h>
> >  #include <linux/init.h>
> > @@ -33,10 +34,13 @@
> >  #include <linux/units.h>
> >
> >  /* Loongson PWM registers */
> > -#define LOONGSON_PWM_REG_DUTY                0x4 /* Low Pulse Buffer R=
egister */
> > +#define LOONGSON_PWM_REG_LOW         0x4 /* Low Pulse Buffer Register =
*/
> >  #define LOONGSON_PWM_REG_PERIOD              0x8 /* Pulse Period Buffe=
r Register */
> >  #define LOONGSON_PWM_REG_CTRL                0xc /* Control Register *=
/
> >
> > +#define LOONGSON_PWM_MAX_LOW         GENMASK(31, 0)
> > +#define LOONGSON_PWM_MAX_PERIOD              GENMASK(31, 0)
> > +
> >  /* Control register bits */
> >  #define LOONGSON_PWM_CTRL_REG_EN     BIT(0)  /* Counter Enable Bit */
> >  #define LOONGSON_PWM_CTRL_REG_OE     BIT(3)  /* Pulse Output Enable Co=
ntrol Bit, Valid Low */
> > @@ -118,20 +122,20 @@ static int pwm_loongson_enable(struct pwm_chip *c=
hip, struct pwm_device *pwm)
> >  static int pwm_loongson_config(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> >                              u64 duty_ns, u64 period_ns)
> >  {
> > -     u64 duty, period;
> > +     u64 low, period;
> >       struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip);
> >
> > -     /* duty =3D duty_ns * ddata->clk_rate / NSEC_PER_SEC */
> > -     duty =3D mul_u64_u64_div_u64(duty_ns, ddata->clk_rate, NSEC_PER_S=
EC);
> > -     if (duty > U32_MAX)
> > -             duty =3D U32_MAX;
> > +     /* low =3D (period_ns - duty_ns) * ddata->clk_rate / NSEC_PER_SEC=
 */
> > +     low =3D mul_u64_u64_div_u64_roundup(period_ns - duty_ns, ddata->c=
lk_rate, NSEC_PER_SEC);
>
> This is wrong. Consider clk_rate =3D 1234567 and the request duty_ns =3D
> 1234 [ns] and period_ns =3D 123456 [ns]
>
> Then you get
>
>         low =3D (123456 - 1234) * 1234567 // 1e9 =3D 150
>         period =3D 123456 * 1234567 // 1e9 =3D 152
>
> so the actual duty cycle is (152 - 150) * 1e9 / 1234567 =3D
> 1620.0011826008633 which is bigger than the requested value.
>
> The correct approach is
>
>         duty =3D mul_u64_u64_div_u64_roundup(duty_ns, ddata->clk_rate, NS=
EC_PER_SEC);
>         period =3D mul_u64_u64_div_u64(period_ns, ddata->clk_rate, NSEC_P=
ER_SEC);
>
>         low =3D period - duty;
>
> which yields
>
>         duty =3D 1
>         period =3D 152 (as before)
>         low =3D 151
>
> .
>

Thanks for catching this. I'll update the calculation as you suggested
in the next version.

> > +     if ((!FIELD_FIT(LOONGSON_PWM_MAX_LOW, low)))
> > +             low =3D LOONGSON_PWM_MAX_LOW;
> >
> >       /* period =3D period_ns * ddata->clk_rate / NSEC_PER_SEC */
> >       period =3D mul_u64_u64_div_u64(period_ns, ddata->clk_rate, NSEC_P=
ER_SEC);
> > -     if (period > U32_MAX)
> > -             period =3D U32_MAX;
> > +     if ((!FIELD_FIT(LOONGSON_PWM_MAX_PERIOD, period)))
> > +             period =3D LOONGSON_PWM_MAX_PERIOD;
> >
> > -     pwm_loongson_writel(ddata, duty, LOONGSON_PWM_REG_DUTY);
> > +     pwm_loongson_writel(ddata, low, LOONGSON_PWM_REG_LOW);
> >       pwm_loongson_writel(ddata, period, LOONGSON_PWM_REG_PERIOD);
> >
> >       return 0;
> > @@ -166,15 +170,15 @@ static int pwm_loongson_apply(struct pwm_chip *ch=
ip, struct pwm_device *pwm,
> >  static int pwm_loongson_get_state(struct pwm_chip *chip, struct pwm_de=
vice *pwm,
> >                                 struct pwm_state *state)
> >  {
> > -     u32 duty, period, ctrl;
> > +     u32 low, period, ctrl;
> >       struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip);
> >
> > -     duty =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_DUTY);
> > +     low =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_LOW);
> >       period =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_PERIOD);
> >       ctrl =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_CTRL);
> >
> > -     /* duty & period have a max of 2^32, so we can't overflow */
> > -     state->duty_cycle =3D DIV64_U64_ROUND_UP((u64)duty * NSEC_PER_SEC=
, ddata->clk_rate);
> > +     /* low & period have a max of 2^32, so we can't overflow */
> > +     state->duty_cycle =3D DIV64_U64_ROUND_UP((u64)(period - low) * NS=
EC_PER_SEC, ddata->clk_rate);
>
> What happens if low > period?

pwm_state_valid() in drivers/pwm/core.c ensures that duty_cycle <=3D
period before the framework calls the driver's .apply(). Since this
driver always programs low =3D period - duty, low cannot exceed period
when configured through the PWM framework.
>
> >       state->period =3D DIV64_U64_ROUND_UP((u64)period * NSEC_PER_SEC, =
ddata->clk_rate);
> >       state->polarity =3D (ctrl & LOONGSON_PWM_CTRL_REG_INVERT) ? PWM_P=
OLARITY_INVERSED :
> >                         PWM_POLARITY_NORMAL;
>
> Best regards
> Uwe



--=20
Best regards,

Keguang Zhang

