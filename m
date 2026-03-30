Return-Path: <linux-pwm+bounces-8425-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rEFgDzzwymm3BgYAu9opvQ
	(envelope-from <linux-pwm+bounces-8425-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 23:50:52 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC517361992
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 23:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74399301BC01
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 21:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0C43A5452;
	Mon, 30 Mar 2026 21:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="h4CWypCb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E223A0B31
	for <linux-pwm@vger.kernel.org>; Mon, 30 Mar 2026 21:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774907085; cv=pass; b=ThOh8q6YFN9GUZqsRSKjWPAwC1vBIh+eHyonQmbBRdal+u1OcsX59v5Wz7T5OtnNmBJ/snNighrzGAUMlOj5G3lsEj0+2Imv9FaKvPf41ZsOlZQDJ1tqQniW3Kb1aSmQnEMOylPGFUX7unSS4HdAkULqqXeQ+FMC6DHXeHOU+xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774907085; c=relaxed/simple;
	bh=joXl5W/My3zoQvxu423mjsgVhtX//AxggfI6qzYeX1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVH2Mg3RNjA7YM2WuBtDmC/pyyTqwKs2QXWZyB6C7z7XAIfJX03+5CpBmO2S149+EOHqew/1Qxsql7erAeLMlIXG6XO0bTb1HjRA4djjEP2N5xb3AqSnbP+BXXZxHUZB0k4jEKhqiw1dTZox8FBExlH1rvkfsGkib7ZLlLhOsLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=h4CWypCb; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b24fdac394so16705265ad.3
        for <linux-pwm@vger.kernel.org>; Mon, 30 Mar 2026 14:44:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774907082; cv=none;
        d=google.com; s=arc-20240605;
        b=BQHw1IJBIjgTrCL3iwYVfIox8NXg6g/pU+3gIEPn59QK+/X6Up9uZmVut0ihYFGWst
         C/Dn/Gv5loJQOi9ghMD73cKciC0Ml4DxOmTOtFI2l21aWrMWyPyqyzjqLGd6cU6XMqId
         myJvGztAdLVw0p1jInozO9bG3eivCpWMGQuHIfjNu/NFS8/c4AefOd6g7VeLxhy3cUCW
         b+sd3idpaxJdcfN5qKl4Ul0WTJcQQvDVgFHp6PlGb289YMqPyXItyCdhJP0No/w2NMHx
         OJH1a2825hzSdfPHj1/Es4r5GPYtEERbEVwraOwBccolHfLx3uVIbzlPwhcw+cHry0JN
         9fJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IY6TefpABY+FWNRT3kahjkpIdjUN+0MXMlIzQOjUTr0=;
        fh=hbXLiijSHMbfkFyjVkcrY4DM52e4MMtg4+8xxgvqQJU=;
        b=FdaJ71qakaGnVV164JNlIjIpxS5MZv6x0+Iyetsx+USpizkSdeLV3Sqjc3wchWdjY8
         CTIGuM39cxzzynOUkL6WNpHCCy6TO4Ccd83h1n4TA4N/5HLwNDBRq0AJBc+zwd3l3D4b
         hqaG3QsJh2wprojlLKDKxLmOioptkCa0EoQBbYQTronmgjP7nNmZG4BdjWZ+y5sYNbvf
         jNI3VGh61J3ZiOCWsT5TGJpfXNZ9gQeYTdg3JD7iP4UP7hUir+YJm4sFJO8uAyW+l9Si
         dUAa2FYOTyCxtlimvAdZ4F8KLODAxAOLH2DOGDz4xI2uLe55uLsrA6JOBpCLfw/lAzAU
         YD3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1774907082; x=1775511882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IY6TefpABY+FWNRT3kahjkpIdjUN+0MXMlIzQOjUTr0=;
        b=h4CWypCb0BSE51L7iQj7Kgzx8fCgyA9caHJLIWKS2zsI8FqZwVg1lczKwM6WdpD0zx
         onY1nqT3FXH6QNIFDu1+MObQa8RkYopMQb4Qhwso+mMHLTlpHgdxIRV7UGm2folQekXY
         9bnEAI2lqOPqHWGtUZh0UxME7vc/qPsx6igtRQNkY9N1223vG1pUyw1T8LhY3rGzz0NK
         PlPd3PRGpZTa+ZGjFLOVxWYllHtlcT2o8X56p0nkOe0CxHRh8mi1E5ITNfOmT9n6DnN/
         owMmIIAvULfCpeookYVJbdTSCJzdafu1vIg6kYEeYclzW0aCcGMtfhiyFYV3n4pWOQCQ
         62Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774907082; x=1775511882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IY6TefpABY+FWNRT3kahjkpIdjUN+0MXMlIzQOjUTr0=;
        b=qzfjt+oPFHNRv1uYWtSokt4OSPwivDzqZU56X//jTJvbcfaoHy40aiN8i5VD6UqT8P
         W2iRj5B/TJnUrN/z0OnKwuzSzpkMdkSScFt2YzjljgSWcaTgFFkcTLLdOpnQY45bMPzU
         jxr8VCbAYqLC+CQdSQdjYXe3TGLWF0Iaq1RvKwzP6AC+1KqgJyP6aeAmd7I1gNgwBrVc
         SPpkXf7NBsmsl20lhn3nB1KLEUbxvv5Kx//lpP1RRJVZ7m3+HVf72einRQBkHjKaG4Hv
         NERwVjnxd119JYbrrE1a5buGGbQ+082zYuvq7LE3QJGpM6R34G1RgEQrB3DwqgbCN20e
         ff2w==
X-Forwarded-Encrypted: i=1; AJvYcCW6RFX6gKZCwStX7RL/wK9nL84ooFMLLJcsmD3RM3VVyqz21cnjPgRzxHOTOAKjPPbnn9vP1d0EYZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhth20BAHdOF+/vTL0fhAZzqz0bVrMSbvSzHhLrO83TFVbQk0I
	3gX+gKXS4hZew6dM5HiwNOq7/2CiBE5KvePVkGcbZqRBMrMa5imnYYugPbGir/BVp3phubDqDik
	MjZIJeQBewV/fakPyPmtz4pgOr+elwC4=
X-Gm-Gg: ATEYQzygAlUEEHLd/BrBwOgxWYD09jQny+ghRVj7pb1lwlPsFQFQebU3mnPzueCSDll
	U6Mc91DhTzf5qXuqtFTKjGujMnXnDnSR1Z64nGLz5lV4zXY9gMVXkx1fXxGI8G3sOCG1lrK2Fyr
	Ach2xbGDBgP8N0l0BVH2+JvmG4Qp9h9B9EjxFixzbxXB96Nx8ffpJY3js5q4sOPzciUlGBB/HmW
	rrWXpSmU88XCkf+r52weiWTzf+IaY6XKfiYgCWGhkQpVCFMlnL9S0IVpB+LkMZLO9e2iImB2VCZ
	OnJlv3CRVyWyKSoq3eqZdt4HcQsBn8NgRd5/UW8d
X-Received: by 2002:a17:902:e847:b0:2b2:54e5:b3af with SMTP id
 d9443c01a7336-2b254e5b653mr47612585ad.45.1774907082131; Mon, 30 Mar 2026
 14:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326-s6-s7-pwm-v1-0-67e2f72b98bc@amlogic.com> <20260326-s6-s7-pwm-v1-2-67e2f72b98bc@amlogic.com>
In-Reply-To: <20260326-s6-s7-pwm-v1-2-67e2f72b98bc@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 30 Mar 2026 23:44:31 +0200
X-Gm-Features: AQROBzDFiVgbyoC-RBIZt33tOxsaNE_LH0olelId_HKu2Jck3TyhrNiFIv2aRxY
Message-ID: <CAFBinCD-4dwp7pmM_GHK_N1kag_5VBZbP9VAwQOxcyg6aquj3w@mail.gmail.com>
Subject: Re: [PATCH 2/2] pwm: meson: Add support for Amlogic S7
To: xianwei.zhao@amlogic.com
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8425-lists,linux-pwm=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[googlemail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martinblumenstingl@gmail.com,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linaro.org,baylibre.com,vger.kernel.org,lists.infradead.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlemail.com:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC517361992
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Xianwei Zhao,

On Thu, Mar 26, 2026 at 7:35=E2=80=AFAM Xianwei Zhao via B4 Relay
<devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
>
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>
> Add support for Amlogic S7 PWM. Amlogic S7 different from the
> previous SoCs, a controller includes one pwm, at the same time,
> the controller has only one input clock source.
>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  drivers/pwm/pwm-meson.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 8c6bf3d49753..3d16694e254e 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -113,6 +113,7 @@ struct meson_pwm_data {
>         int (*channels_init)(struct pwm_chip *chip);
>         bool has_constant;
>         bool has_polarity;
> +       bool single_pwm;
At first I wasn't sure about this and thought we should replace it
with a num_pwms (or similar) variable.
However, I think it will be hard to add a third (or even more)
channels to the PWM controller (not just from driver perspective but
also from hardware perspective). So I think this is good enough as the
choice will only be 1 or 2.

[...]
> +static const struct meson_pwm_data pwm_s7_data =3D {
> +       .channels_init =3D meson_pwm_init_channels_s7,
I think you can use .channels_init =3D meson_pwm_init_channels_s4, if
you change the code inside that function from:
    for (i =3D 0; i < MESON_NUM_PWMS; i++) {
to:
    for (i =3D 0; i < chip->npwm; i++) {

[...]
> @@ -650,9 +674,13 @@ static int meson_pwm_probe(struct platform_device *p=
dev)
>  {
>         struct pwm_chip *chip;
>         struct meson_pwm *meson;
> +       const struct meson_pwm_data *pdata =3D of_device_get_match_data(&=
pdev->dev);
>         int err;
>
> -       chip =3D devm_pwmchip_alloc(&pdev->dev, MESON_NUM_PWMS, sizeof(*m=
eson));
> +       if (pdata->single_pwm)
> +               chip =3D devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*meson)=
);
> +       else
> +               chip =3D devm_pwmchip_alloc(&pdev->dev, MESON_NUM_PWMS, s=
izeof(*meson));
I don't think this code is too bad for now.
However, I'm wondering if you want to make "channels" from struct
meson_pwm a flexible array member in a future patch. In that case it
will be helpful to have an "unsigned int npwm =3D pdata->single_pwm ? 1
: MESON_NUM_PWMS;" (or similar) variable to future-proof your code.
What do you think?


Best regards,
Martin

