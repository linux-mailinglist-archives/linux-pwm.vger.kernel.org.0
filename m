Return-Path: <linux-pwm+bounces-4977-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 206EBA431D7
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Feb 2025 01:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11457176946
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Feb 2025 00:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240131862;
	Tue, 25 Feb 2025 00:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QTFkfUfg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308295672
	for <linux-pwm@vger.kernel.org>; Tue, 25 Feb 2025 00:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740443204; cv=none; b=PYDxz1PMHS1V/w7fW9oP0bdY10QuwPA2Y/JltiOvse3lz3h2q8xHG4DQQHeGeZ3/CufC6WX9bKe4MVxDBzmn0AXTd6XQPUx92tIEm9q36ZywXv9340zf9Uwnx6FxErPHWnnT332jpeuNL8QorDLL/5ELgeRbvGnytIlV8zLu0DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740443204; c=relaxed/simple;
	bh=mMBnj8wAn9tmIcP4sfb5TDnm+di1BZsgRnF82TUYO14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nDDEBypmXsQCJu2StqNtdt7/gtL0KNP0IMXrawB1yztLXvvYFZFUHU1nV9q6E6bjnS55eQUqnzgS5TYE3iS3T96ut+NESuYs5XUKpRCZ5Q8+IOqcz0AjqZWNIb76iuK4YmbZI0lW1OijyQTiIYxAixuLcydy1f9MuoPvsTuD66Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QTFkfUfg; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5462a2b9dedso6007884e87.1
        for <linux-pwm@vger.kernel.org>; Mon, 24 Feb 2025 16:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740443198; x=1741047998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MonBVftq71LB80zSOFj1KpiAwzenwGE0PbED6OoLK8c=;
        b=QTFkfUfgCu8ZIn9tvKRwtWRf4Ck7/8SIA3u822V9j2U91SQUooD2Gw4Exxc/87UpgP
         tUzPh0u7pY2aLXPHcIHWU4+ytbKIxoKIUng+YkrMEeu7g40eZKiyEx4kJLf5mxadgCDz
         pATdhnoB+lSPwp+KGIwViNhoxmQp+g7d3wfqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740443198; x=1741047998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MonBVftq71LB80zSOFj1KpiAwzenwGE0PbED6OoLK8c=;
        b=arcRpK1toqIIAv/5Yj1ppz32bTOwIvkAYR2G6cu8Alt+hRYUj+Hmon/B+EWzRgLQ4O
         LleMvG/eYp+/ZrzM4J0u5HKP8JNNAfh0K/1GDN1aPgrYsUjvMf4G89U5xsOYalAjtd15
         P6RpWCpDxwI/Ucxp1+xDkFugUrFDP7U2VNE51KDWgU0GMvFkHY+lc9wSwACf4pomb8o/
         3hYZqZ5XZLqivQf5chkVKzDPyabJ9GtMb9jOb3uvLVc/f0A77ua1dWJfKIEmiiCROoXF
         tc/Y13TbZFcCErw0eAcups2eYbjypEFt+CB9oNdCyjFgKT7AMUzdHQPNFg5UAPZ0AB/3
         IZlw==
X-Forwarded-Encrypted: i=1; AJvYcCVCqlUoikRI7fUbQVmFcQZ0rkIoqzpgf0Us5RM9qxYMnazYE6Zl1ooAnaIohTOolDpZXedtwj7utVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBMR1a/tkz+tJZggMCF74Cj+kgUzmSbnuJ8UPYJKRsa4yYjNcX
	yWNY4dDFW1OCLJ7aj5OpCNd3lJkUYbTNRtIVrUgPRsR9G4tw1C17fJzVBISmZCMLv9tdxmLhc3A
	rCg==
X-Gm-Gg: ASbGncs8De0aCVr3lL0YQGmGltn63uwfpycNlSQMUm/AWI1MiZ4SYMsgTqwo+d6xy8K
	kPFF7toTH4D7feUyGabYH+VSYc+JAm7arNok6koiDYn/6XKZDS8WvviZ/h1KFj/vjMiTWalYrDB
	rqa05aVJ1Ltqh/mouDL7e9+8qRLJ+aRH6Bvgckhe43pp1yiFQrvqhHqxnPH3I78Pg68ArWbDxRq
	8928RC3GZZvndKKj+hMQ0FYVkPfPop6QybQwUJyaQDiN1pfIRnqzH+Nq657LVpsDXW/g7WUNF1F
	kFLSY67R9II0SLkK2VOyfGXkw1lnED5NG/5MDv1N0zxKI/79WK+cnk/4uvjw+mYbFqH9nw==
X-Google-Smtp-Source: AGHT+IEfT/cZfKBtvaww3Se+aUlZIADiyvxkpxX9PqeVcuKPzRE1pFiFBq/+5zN2ya6/HEBRX32QKg==
X-Received: by 2002:a05:6512:12ce:b0:545:109b:a9d4 with SMTP id 2adb3069b0e04-548392713a4mr6839287e87.43.1740443197896;
        Mon, 24 Feb 2025 16:26:37 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514f4d88sm36752e87.192.2025.02.24.16.26.36
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 16:26:36 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3061513d353so52677331fa.2
        for <linux-pwm@vger.kernel.org>; Mon, 24 Feb 2025 16:26:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXasLcfvj8hOhowvSRG38p64vs5KAKiZV7MF0MemjIW4AXKyOTlRHthCn8YSanm5X/YITSfyfBRUVU=@vger.kernel.org
X-Received: by 2002:a05:6512:2214:b0:545:23bb:23f4 with SMTP id
 2adb3069b0e04-54839129a5amr5535877e87.8.1740443196300; Mon, 24 Feb 2025
 16:26:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217174936.758420-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20250217174936.758420-2-u.kleine-koenig@baylibre.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 24 Feb 2025 16:26:24 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XhS6kaYm2FbdOcqeFTHJN=H5B3QBa2yHc-tk-E=2TJ6A@mail.gmail.com>
X-Gm-Features: AWEUYZl2Mhiqo6raYNMP-1ZeB3LqAFThBdttHbacGYJMZcSHZ-EkeSwClwp4YDk
Message-ID: <CAD=FV=XhS6kaYm2FbdOcqeFTHJN=H5B3QBa2yHc-tk-E=2TJ6A@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Check for CONFIG_PWM using IS_REACHABLE()
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 17, 2025 at 9:49=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Currently CONFIG_PWM is a bool but I intend to change it to tristate. If
> CONFIG_PWM=3Dm in the configuration, the cpp symbol CONFIG_PWM isn't
> defined and so the PWM code paths in the ti-sn65dsi86 driver are not
> used.
>
> The correct way to check for CONFIG_PWM is using IS_REACHABLE which does
> the right thing for all cases
> CONFIG_DRM_TI_SN65DSI86 =E2=88=88 { y, m } x CONFIG_PWM =E2=88=88 { y, m,=
 n }.
>
> There is no change until CONFIG_PWM actually becomes tristate.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
> Hello,
>
> even without the change to make CONFIG_PWM tristate using IS_REACHABLE()
> is the more idiomatic way to check for CONFIG_PWM.
>
> Note that IS_ENABLED() is wrong in the case CONFIG_DRM_TI_SN65DSI86=3Dy +
> CONFIG_PWM=3Dm.
>
> Best regards
> Uwe
>
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

This has already been on the lists for a while and nothing here is
controversial, so pushed to drm-misc-next:

[1/1] drm/bridge: ti-sn65dsi86: Check for CONFIG_PWM using IS_REACHABLE()
      commit: ed531feda7852de0aa702fbe3d23a0f743ccc77b

-Doug

