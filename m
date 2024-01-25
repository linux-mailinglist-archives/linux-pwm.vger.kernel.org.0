Return-Path: <linux-pwm+bounces-1070-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48E483CA4A
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 18:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B21E29409C
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 17:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080A9131727;
	Thu, 25 Jan 2024 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Iai+swkE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6FB129A73
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 17:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706204908; cv=none; b=uCRzIJapBmh/15faZa1ZYHFRLfYzuvrkCHwiL0o1onJAnx9cdenuSyjjd5REngrKkwYzIYPspg+YO1WvnvVMZoQSoWIgJWtTgoBaYqNVbXRs1CxETtKPqb1ffQDEn/49G0/IviC29IcxilccIkaVXT+kcM7tgVXA1oTNaDwngoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706204908; c=relaxed/simple;
	bh=5+fKpkYglqqr18Q42ScQr9ZZt0k4KEDEt9yQuGh8teU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/DPlDuO+ByGajcgi5Za9M2LrSn+/c0f3Zj1a87Eve0pDnelA8Q/CRuOz/JUKGF3aeqCDffbJFuMfN2kOCf0Otff9Og2yNTN0FxxYVB+g/FcBNGuHosh5JGFpQEydE/HNen3LUsmpjtoAOgAz8MbUpMe0VrcmdSkxjikS7+fBFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Iai+swkE; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55cef56c6f9so1344267a12.3
        for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 09:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706204903; x=1706809703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QQ5xywaldx4inPhMAC8V1N2G9UQEtEowfFIay8eCsg=;
        b=Iai+swkERKMY8p/vS9MXlbUV9sV1BlqIUtxTIvTmap8IeeW6p3Q21qeMDF0GxACkUg
         sN+ufQa1x+FBuabDZMN3enkHq9Gjms5XJOykHBLuzI0bU07XlKpVFj/dH29qyUhiiGYo
         DRCD/uLH7rG3CHLJYcnyjkMile2Jpq1CyLUd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706204903; x=1706809703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QQ5xywaldx4inPhMAC8V1N2G9UQEtEowfFIay8eCsg=;
        b=dCHI0wnp8AzjrEe8+qNPm+304+RbsXQosD8HneerWT5Nreb1duMmNpfuq5CRZzIzMa
         bm8tKzrx+hJCA4SHZgo3IyCtwly/5aJhuY5X9Z6fnYVxLgs3Uz8LBSpN/IlVuqFJ44vE
         RASNgIXhoB7g8fL+Ln5/sJEba2io2l6ux7UeyLTQqjIjYH8n7wB/G07UfVTkanbzSE9D
         EAA2L4Y/lLw3DputA/dILWJuiIRuARaKJ4/Vk7mFGVOn2WfGLg5Ok0pN2HFfhYKnrHIF
         LMz4K9drAy/GoIu9GGfBhqSueVcRROSirzQLtwngVtMzDhVopZRkdYStXWf6xFyNRlnm
         M41g==
X-Gm-Message-State: AOJu0YyL7ak5QcuukhX8RSVlH1KDqVwyaNu4bzmOmL5Xq7/IQheAxe/j
	C1si4yvZtI3EK7lOvxUar4vIZKqlMugx9VMIMQc6iJA7yD9jkvC1G4AuLWYYYrzFEyls2jRsgiS
	JEA==
X-Google-Smtp-Source: AGHT+IF/SmTY2FXj8CEVna2g65d3XVkkg4Phz7ni4GC1T8gr3J9rVJUKin3mnSwOrE9noalX5a+uAw==
X-Received: by 2002:aa7:cf98:0:b0:55c:7afd:6075 with SMTP id z24-20020aa7cf98000000b0055c7afd6075mr672580edx.66.1706204902962;
        Thu, 25 Jan 2024 09:48:22 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id t4-20020a056402020400b0055c26f9275dsm5135487edv.42.2024.01.25.09.48.21
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 09:48:22 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e865bccb4so1145e9.0
        for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 09:48:21 -0800 (PST)
X-Received: by 2002:a05:600c:3b1c:b0:40e:61cf:af91 with SMTP id
 m28-20020a05600c3b1c00b0040e61cfaf91mr160203wms.7.1706204901267; Thu, 25 Jan
 2024 09:48:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706182805.git.u.kleine-koenig@pengutronix.de> <0316aaec9dbfc0c73788bcd3ee532ae7ecadb180.1706182805.git.u.kleine-koenig@pengutronix.de>
In-Reply-To: <0316aaec9dbfc0c73788bcd3ee532ae7ecadb180.1706182805.git.u.kleine-koenig@pengutronix.de>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 25 Jan 2024 09:48:04 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xscb2kv6drrqBBT2MOA0cSO3=oVZ4Hw3sKTo-uUuqQ-w@mail.gmail.com>
Message-ID: <CAD=FV=Xscb2kv6drrqBBT2MOA0cSO3=oVZ4Hw3sKTo-uUuqQ-w@mail.gmail.com>
Subject: Re: [PATCH v5 104/111] drm/bridge: ti-sn65dsi86: Make use of
 devm_pwmchip_alloc() function
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-pwm@vger.kernel.org, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, dri-devel@lists.freedesktop.org, 
	kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 25, 2024 at 4:11=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> This prepares the pwm driver of the ti-sn65dsi86 to further changes of
> the pwm core outlined in the commit introducing devm_pwmchip_alloc().
> There is no intended semantical change and the driver should behave as
> before.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi86.c
> index f1fffbef3324..7fbc307cc025 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -197,7 +197,7 @@ struct ti_sn65dsi86 {
>         DECLARE_BITMAP(gchip_output, SN_NUM_GPIOS);
>  #endif
>  #if defined(CONFIG_PWM)
> -       struct pwm_chip                 pchip;
> +       struct pwm_chip                 *pchip;
>         bool                            pwm_enabled;
>         atomic_t                        pwm_pin_busy;
>  #endif
> @@ -1374,7 +1374,7 @@ static void ti_sn_pwm_pin_release(struct ti_sn65dsi=
86 *pdata)
>
>  static struct ti_sn65dsi86 *pwm_chip_to_ti_sn_bridge(struct pwm_chip *ch=
ip)
>  {
> -       return container_of(chip, struct ti_sn65dsi86, pchip);
> +       return pwmchip_get_drvdata(chip);
>  }

nit: given Linux conventions that I'm aware of, a reader of the code
would see the name "pwm_chip_to_ti_sn_bridge" and assume it's doing a
container_of operation. It no longer is, so the name doesn't make as
much sense. ...and, in fact, the function itself doesn't make as much
sense. Maybe just have all callers call pwmchip_get_drvdata()
directly?

In any case, this seems fine to me. I haven't done lots to analyze
your full plans to fix lifetime issues, but this patch itself looks
benign and I wouldn't object to it landing. Thus I'm OK with:

Acked-by: Douglas Anderson <dianders@chromium.org>

Similar to the other ti-sn65dsi86 patch in this series, unless someone
more senior in the drm-misc community contradicts me I think it's safe
to assume you could land this through your tree.


-Doug

