Return-Path: <linux-pwm+bounces-2553-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C780290EE5C
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jun 2024 15:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3681F2302B
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jun 2024 13:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A13414BF8D;
	Wed, 19 Jun 2024 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QP3fv3+W"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3196814373E;
	Wed, 19 Jun 2024 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803676; cv=none; b=TGM01Qzez7deyC/Z0SmgIgxov7xfwp7qf6Tx7Up0DjetHicOmZhsUCQgvIJWQOCcwFy3y0B2ukVjSsoTbfa5HQzmfFyx3GKRBEj8V9BjXVPuBVEbbrcloe/ohG4SF0SiaJJrZ9TeITu0sVHSMYS+vTRYmr3pDc86mtuuSrwp6DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803676; c=relaxed/simple;
	bh=rCR7QuMaFcOz1m7J9fyPFPxCKL6AfHbaF5fRTnWNcm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0V5Cc1bkJ+JeWgRWrV+yj5uXjljiSSan5034spXnBfrPKmq2fuwhKGhlvj+FZDQX4szPWzz1wguJgUk8RNSpejDJMJAt7S59aBT8DbFKSFJuVp/4/U/ymDF+dXuS6lKjq6wSVEv0jniym6xJNEbrsWjG/rLQ9/9YqGpkCefRRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QP3fv3+W; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-80f50dadadfso490368241.1;
        Wed, 19 Jun 2024 06:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718803673; x=1719408473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+EdAOsIyAeNB2MEPeOqJ21gcXQroPI9pOzshoyJ47o=;
        b=QP3fv3+W56QV7UuVAXuiJlym4GgyYQHId/jUXlxwzwPkMwHrMdvANdAlqqQYMtGf5p
         Bzssto5mHvsI/GD0o5EwMsTuNtACFimiOk3542PgeSyqcACHrOyDAQLAFtL+iNumAaIt
         WnhIixWXnpONc+3KewbACFsIR100GanZADsNZWTLCCUe1su5Yw1BM8g4vqkqhMNVq2qw
         JaTxazc0JJze4U+9j5aNpQkqHIrVXoKACjXkHK2yrUqYGYiu8DYOkMlNe9oIqtAEeKKX
         cnTRFB03yMhxG7e5iROZsYGDxfgKLlCcB8/WRhNrLHHtU1Ksz4u67kK1m8WAeYtf/4W1
         sgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718803673; x=1719408473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+EdAOsIyAeNB2MEPeOqJ21gcXQroPI9pOzshoyJ47o=;
        b=pfLzGOYytYSReNVLknEBZU8zrvehkZbkIVHtTHHY/jtoriWdOm4hcqok7OVkxShRg8
         xk02bX0nkeNQwJb2wlo1+Mf24v3gk0jqInZJ+FcEliR231DwY9NlAXRPKODpLw8IThri
         A9irogKS/vrdyNoTO3uroaZm/1oaVakOWDzBz+5Pre2lmXePGDJirYjeoSd+QzbtCLLz
         kGZ6z5yFjQran20suzkCc7Pzbyq/lAQ4laAM1VOtmvM/aWYFayEMuoO0J0bewU575Gt2
         EoBabAGScHakjYsQHW6sL+SQiGeIxfClmaayeTAtCRORq7wopnGd80hR9z6pDsiuEEUr
         nDHw==
X-Forwarded-Encrypted: i=1; AJvYcCUbYDxjS5dK7irEhd57hm+ApgPu20AaBJrz+5KTDMtSVfV/xoerJHqnY1pyidvreYa2UdYk6GM6RqNkIT4UmOFOozRycbwzPh8IAHJJLbT4Ba54dO/1umBTOkmfiU70/OMIE4lR5DOwkuisTW2FHV//koLVmb6G2bmVKw2B4j4hJhHCEjsbAv4bT4CKgqsXke6njx02hKHrZ4e0FUf/UwfikHLE/5ofgflCO9hnDcjUlTQcv5NNQe6rrYgxcfl0+ahjC2AbXdXmRybTJh06z0cwkrRj/4o9NRaX3k33nkC3zFE4bJ4lPcfBLsTRigMQkH+xZez2AxHU1mUmD4cAYsZnrVKNSaUjK5xmEnhns5HfyIzmSS+ytMchdVxA7TWJgZBdcyn1pHlZS+aug3prhgL4/IlTp5EzaFhpkAt09w4dh8kvFgCpNcFJdCIebM1pmrg=
X-Gm-Message-State: AOJu0YwL+uZy8sFlSUBlunvKpmdjSUJkYl9ZmHhlLB6qoX1KkJA1OuFl
	RcoADOg20Y4ZFFQEPPigLHjcSex1aHxpMFW9ebZRLf3ANBOiJi6GHvBcHcXIX/EC5OYDh7JurtD
	w+yZLDvBPXRmTIuEuN7lEGgb1EA8=
X-Google-Smtp-Source: AGHT+IGwE8bFf/VlY/jk/YXUnYkoze8GDMP6nvE5vZma8oxX1CjkKEtLu+mwZHIrK4bFz/7xDykwdahIAJ7lHkmGhA4=
X-Received: by 2002:a67:ee4b:0:b0:48d:8904:3dad with SMTP id
 ada2fe7eead31-48f13140716mr2780689137.32.1718803671634; Wed, 19 Jun 2024
 06:27:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
 <20240618-starqltechn_integration_upstream-v3-11-e3f6662017ac@gmail.com> <pkmxbxoc4sno6mbjsftz6hp5lxefc6yhwxjlhiy2pd4wbkzpvl@as43z4t64mm6>
In-Reply-To: <pkmxbxoc4sno6mbjsftz6hp5lxefc6yhwxjlhiy2pd4wbkzpvl@as43z4t64mm6>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Wed, 19 Jun 2024 16:27:40 +0300
Message-ID: <CABTCjFABEY0urmgrr5E3-oq9u_aNR8KcCTMpJpoGLOTPOfKAGg@mail.gmail.com>
Subject: Re: [PATCH v3 11/23] drm/panel: Add support for S6E3HA8 panel driver
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Chanwoo Choi <cw00.choi@samsung.com>, phone-devel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 18 =D0=B8=D1=8E=D0=BD. 2024=E2=80=AF=D0=B3. =D0=B2 21:39, Dmi=
try Baryshkov <dmitry.baryshkov@linaro.org>:
>
> > +     ret =3D mipi_dsi_compression_mode(dsi, true);
> > +     if (ret < 0) {
> > +             dev_err(dev, "Failed to set compression mode: %d\n", ret)=
;
> > +             return ret;
> > +     }
>
> Interesting, compression mode is being set before the PPS programming?
>
Yes, as per vendor kernel:
https://github.com/klabit87/twrp_android_samsung_kernel_sdm845/blob/e8bb630=
39008e1704a2f1bde68d39ded9c16ea88/drivers/gpu/drm/msm/samsung/S6E3HA8_AMB57=
7PX01/dsi_panel_S6E3HA8_AMB577PX01_wqhd_octa_cmd.dtsi#L5508

