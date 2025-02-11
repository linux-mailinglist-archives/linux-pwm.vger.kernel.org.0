Return-Path: <linux-pwm+bounces-4840-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8F5A30521
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 09:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45763A4B3C
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 08:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C711EEA2F;
	Tue, 11 Feb 2025 08:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ay4ym5Bv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5AC1EE7DF;
	Tue, 11 Feb 2025 08:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739260941; cv=none; b=K8c7d1GgpVJRqhwuDC76PTmeEUXAfzJ/plzZrejpgMHynDZnX5fT7dWBErJ8jTDsZ2geFf81hfkXFsAz6d8E7W3wTpOJJsG8h70QPyRCarbg1S9waHup3vqQvRIJwkCT1wf1I9AfmGFFECtdgzfx+42oQpe/X3ckFkWMyBtnsMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739260941; c=relaxed/simple;
	bh=+uHQKTIzq5GE3CWvKvtfbS7YT9eH9p4Dx3wyUgQGlJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EtnRuMj/ACH2WZohtO85VoRWQ9+4pXJoGQns8wNGGcdasKxetB5+qpXwQ0obD2uiI43XptwNEsUwATLP6SlxdXY8sm106T8mVAPO/Fj6hORSZztlnXUDie+C2ZFSka4+Lfuemv9i2maebE5gR6RRzlzU8CXeKWkj9d99sU/XpTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ay4ym5Bv; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab771575040so1011103766b.1;
        Tue, 11 Feb 2025 00:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739260938; x=1739865738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZFoIS+87CGERMiZGAfXdO21tG9EGSdnHyZy8LxjOHs=;
        b=ay4ym5BvNAPWINZN7Sk2Jay3TdJcBEYfu/Zy+/HkltGy+4UtLLTua4z1oLtktUJrkh
         eDX8SWhg1wquSQEfyEY3QtyCfNIhawEJjthmIJoSOFBjZhO7ZqwT+shKIu9TD04bDnNK
         7DBreiS2p4XT5FdYXklF11ijxeTLcSP5OgiNQ/RQ7bM/TWdOKuZah+Jz7rUFWsP64/Nh
         OC7fPNysofqrPusNH2zIvECXlhQRNkOeNb8kWpSX6DB49+UYfjNnD7icRXptVzK/hDg0
         mV7QPcRSEaPcI2lFHK/nhRwwOr5MyoiDTudtlBDFot8C97PHvgYjoG++0xYRCIrcbtZP
         zWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739260938; x=1739865738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZFoIS+87CGERMiZGAfXdO21tG9EGSdnHyZy8LxjOHs=;
        b=g6ZAItn/hDD+aRhPpgl2JYgZoqWH4H71tgyRgUowrjskQl9cLsKQn3SA5HjlxXwsP6
         FyUaFlmoM/dRjCQ41oJHxAnwPWMNHVS65u0a4adhQJqkpqFLr0+CBehjxoqbwy/dVb7A
         PvEFt/hmZIgRCkHoqmG4egxkGBxvQFl09HDUfcZr+dIbf3/8ERVG2Mm2v1QMkiSknO99
         o1LODrJwV0n+aJ4YiworOxtDoIJeXoLtPs780Gom+zHeIUiaRm2gUC8jgU756uVFKEzb
         h2rZQYKJOWc7+bjm5cq2kSSWC488t9pOw636Smvz7OBp+y5dFzGP3I+7iBVjiqb7xvaY
         8noA==
X-Forwarded-Encrypted: i=1; AJvYcCUMlV15OpGsl5oipmAgAP4cs0A0of1eMabwJQBOidsG/h6xI9nuFGtYqEtpsS6R2HXzqha8vcwCR8zp@vger.kernel.org, AJvYcCWk62VZBu5CeLyUKUA77UFv9/jrPAa5a9szfQLO4cWWozemSNPjutRcGRGL34L0yCQ7D+Kqez58cJqr@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv7o/UQiDZxmkI3i3SFfyaNORIFlYDeONSHaGs+MPWaZOVGaYR
	GjLZSUqfLgtUkf7doJFljcOvBbkN0cgsEY109gGYscfcAhsjul/vn52kv9LK+MbCPAvJgpRlR1I
	aR79MdfbJ8L09f5OEiphcalb6DmQ=
X-Gm-Gg: ASbGncvD/OBwTlylwVKwHzq204gnrHxmTdMuG48rjX+fy4W7uAUCX/BHh0DTRT73Trm
	idaWlvyf9RpVzY24g+KZam7pof4k9YK7MgDgpGVXmkymiApPIoz1wxOp01a570fKDihCBM8U+ae
	4=
X-Google-Smtp-Source: AGHT+IFO9b+MEF0Zijlm2BseQCRKpeRg2dYdZFviAmzJUl45KpyJaKlW+OmrTyKJvhZxgelfvb5X9XS4JahSlUZmBvk=
X-Received: by 2002:a17:907:1c29:b0:ab7:bd8c:3501 with SMTP id
 a640c23a62f3a-ab7db35bf15mr230744366b.18.1739260937390; Tue, 11 Feb 2025
 00:02:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733823417.git.zhoubinbin@loongson.cn> <be76165d1ab09ec41cdfd4e5fbdae1b415f516b9.1733823417.git.zhoubinbin@loongson.cn>
 <obegtfup7f6w6erh4arubk2fkk2wrcum5frs5kbqa4uniexmr5@6uti3d3hv7np>
In-Reply-To: <obegtfup7f6w6erh4arubk2fkk2wrcum5frs5kbqa4uniexmr5@6uti3d3hv7np>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Tue, 11 Feb 2025 14:02:03 +0600
X-Gm-Features: AWEUYZnbIwrCK7szyLgcqOJLyhnXo71Bav9CKmNsq2gv-heSYyMSlwosE83h9Qg
Message-ID: <CAMpQs4+nVSorAeR92F22T5dnzyh1h4BDR6UqrZbTSUhEyWbGyA@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] pwm: Add Loongson PWM controller support
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Juxin Gao <gaojuxin@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe:

Thanks for your review.

On Tue, Feb 11, 2025 at 12:26=E2=80=AFAM Uwe Kleine-K=C3=B6nig <ukleinek@ke=
rnel.org> wrote:
>
> Hello Binbin,
>
> On Tue, Dec 10, 2024 at 08:37:06PM +0800, Binbin Zhou wrote:
> > +static int pwm_loongson_probe(struct platform_device *pdev)
> > +{
> > +     int ret;
> > +     struct pwm_chip *chip;
> > +     struct pwm_loongson_ddata *ddata;
> > +     struct device *dev =3D &pdev->dev;
> > +
> > +     chip =3D devm_pwmchip_alloc(dev, 1, sizeof(*ddata));
> > +     if (IS_ERR(chip))
> > +             return PTR_ERR(chip);
> > +     ddata =3D to_pwm_loongson_ddata(chip);
> > +
> > +     ddata->base =3D devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(ddata->base))
> > +             return PTR_ERR(ddata->base);
> > +
> > +     ddata->clk =3D devm_clk_get_optional_enabled(dev, NULL);
> > +     if (IS_ERR(ddata->clk))
> > +             return dev_err_probe(dev, PTR_ERR(ddata->clk),
> > +                                  "failed to get pwm clock\n");
> > +     if (ddata->clk) {
> > +             ret =3D devm_clk_rate_exclusive_get(dev, ddata->clk);
> > +             if (ret)
> > +                     return ret;
>
> Error message please. Also please make all errors start with a capital
> letter.

Ok, I will do it.
>
> > +             ddata->clk_rate =3D clk_get_rate(ddata->clk);
> > +     } else {
> > +             ddata->clk_rate =3D LOONGSON_PWM_FREQ_DEFAULT;
> > +     }
> > +
> > +     /* Explicitly initialize the CTRL register */
> > +     pwm_loongson_writel(ddata, 0, LOONGSON_PWM_REG_CTRL);
>
> This disables all outputs, right? Ideally the driver takes over running
> channels. Consider the bootloader initialized a display with a splash
> screen. Disabling the PWM might disable the backlight of the display
> which hurts the visual experience.

Indeed, there may be similar problems.
I don't have similar hardware at the moment, and just in case, I think
it would be more appropriate to follow the pwm settings of the
bootloader.
I'll try to drop it in the next version.
>
> > +     chip->ops =3D &pwm_loongson_ops;
> > +     chip->atomic =3D true;
> > +     dev_set_drvdata(dev, chip);
> > +
> > +     ret =3D devm_pwmchip_add(dev, chip);
> > +     if (ret < 0)
> > +             return dev_err_probe(dev, ret, "failed to add PWM chip\n"=
);
> > +
> > +     return 0;
> > +}
> > +
> > +static int pwm_loongson_suspend(struct device *dev)
> > +{
> > +     struct pwm_chip *chip =3D dev_get_drvdata(dev);
> > +     struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip);
> > +
> > +     ddata->lss.ctrl =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_CT=
RL);
> > +     ddata->lss.duty =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_DU=
TY);
> > +     ddata->lss.period =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_=
PERIOD);
> > +
> > +     clk_disable_unprepare(ddata->clk);
> > +
> > +     return 0;
>
> Is this needed assuming that before suspend the consumer stopped the
> PWM?

Actually, I don't quite understand the problem you're pointing out. It
seems to me that the register and clk operations are required
regardless of the state of the pwm.
At least from the experimental results, the logic is now as expected.
Of course, I may be missing some critical information.
>
> Best regards
> Uwe
>


--=20
Thanks.
Binbin

