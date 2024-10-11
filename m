Return-Path: <linux-pwm+bounces-3605-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E721799ACEA
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Oct 2024 21:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 047861C25895
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Oct 2024 19:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B321D0F42;
	Fri, 11 Oct 2024 19:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UhfZ2fZw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50A11D0E3B
	for <linux-pwm@vger.kernel.org>; Fri, 11 Oct 2024 19:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675768; cv=none; b=jjXT0l8EtFFSzoVnuyyJ5gN4Ts8eNCCIkvrpqupw93p9Vl/tZVcNs1vpm6fi6shNT92n7mOq0EbB3z2atLYAr5HZUQUFeXZ2lk7CRxvUKPwK+3U6a2nzFxkmqIiQ1qHL67yqd/lKOQAH5H5d0VRPocAy1j/RMIh5fOCagwpqZvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675768; c=relaxed/simple;
	bh=oEenWqwwBvlWpd2BK+tBQnlRr9uWR7YqbUNUrbjm1dY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6Ora2YtowwWmhv/+hN8FMAE+40vswOTN70uPP8+KpAXyq+6DfI3ZnF4Dd9dfgdc9WTGFWmW5A3RLhbZ4evaPrEYIzjdGRAraWecLGMH9cs146bW+BijvDsHKUSczuMK2wHPhOFuejNvEUJjf7kS98ywJwMG3Mw8YYJHeUN4Ae4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UhfZ2fZw; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb3c3d5513so6403091fa.1
        for <linux-pwm@vger.kernel.org>; Fri, 11 Oct 2024 12:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728675765; x=1729280565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEenWqwwBvlWpd2BK+tBQnlRr9uWR7YqbUNUrbjm1dY=;
        b=UhfZ2fZwmotqQSRxqI6SVo/conmNEVjKjezoALS/HFiBgNMFu3D/vgpdhZe2GoaT1U
         eVcNBkoJRlP+6h5qsoz7c1YCbXKQaPMJiCSMEWv4wTwtu5l+je5k4U1rMboABszu3vT1
         YO8XSR23VIG3TGlq2ye9KiLR+Sh3/6pg8pYfB8JgGI7uA6hkAZNNACj2OD4ukLCG6MuQ
         ocFY8Qx0Z8IzSYzMM7RkFaB9l66it6yAGrhjTgbJFBnRqP+uqAG8NIa3RtKyvYam6Hce
         N2fl/Wz55iCQViChlwoNqSeXXCJw/jg2g93kve1GNtfoYqHlf6Xrzcom+Ho5aIjCIFUx
         eTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728675765; x=1729280565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEenWqwwBvlWpd2BK+tBQnlRr9uWR7YqbUNUrbjm1dY=;
        b=l3DBCZ699PGebJdb2LF9XeIEZguMF8cc5DWjMWEagtx+HL9k2VPZaxdcaS+CFfw0Tu
         rvXyCi9e976UXRgcSMDBtY8aoWcRYp/9Mv9EJ+B4JCdBiwloZJczd/wWjiThIIGbxC6z
         4F38tlQB8WZhTRFcQIQ6pg7JJDrwwNMa/SKVq0fGO9mWEiur5V/j0L9s01my77l5W9gL
         085wh9SsnUm4OC8QKMPoAFUHc1Aw6GMPwBrejphvlAhiKo4NA0FZYulKCrlsMe1ew6ED
         d5gabLXLzV+LqwqVuvOHSoXfsrIUyXYRP/eVAgnWfQc/EE8LtLuAlw4Iko9GyC+x5ThU
         1LFw==
X-Forwarded-Encrypted: i=1; AJvYcCU5MqRiEj+ZPJrKfOME5iSOQHCBxyXOXD4M5BYqAGZ0ZowZoQx3H0v+KTFRbaqFDDG3A9GCxXFzHxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXhzjyZ7YUF4eQxVOgaDnkVdve8dgXNU4J1j5UpMVjN5JY/zwP
	z6tPrUJIiRD8cSpmsC4InCtik9s4m4V8O3T7zJmEzLenJ5KeC+WhWCC+5mQ5J+YbUkzSISJZKty
	BP5BeteWxt6xFHD8Rt2Wb/r+1JLZY//IjFPuUaA==
X-Google-Smtp-Source: AGHT+IFXhtGiu0BS1l/h0GV5cEtsaHcNjwARyABL6VXYXRpwOs+tOyv7UJGbtsSmecdKIGDMRk3CWn21qHwTH7tGwrY=
X-Received: by 2002:a2e:1309:0:b0:2f6:6074:db71 with SMTP id
 38308e7fff4ca-2fb32729553mr14953661fa.17.1728675764928; Fri, 11 Oct 2024
 12:42:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007102549.34926-1-brgl@bgdev.pl>
In-Reply-To: <20241007102549.34926-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Oct 2024 21:42:33 +0200
Message-ID: <CACRpkdajEnP=-7ia3L7sr3v02ePWqKbC2PukSLXRBecsVT6Xpw@mail.gmail.com>
Subject: Re: [PATCH] gpio: vf610: use generic device_get_match_data()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 12:25=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> There's no need to use the OF-specific variant to get the match data.
> Switch to using device_get_match_data() and with that remove the of.h
> include. Also remove of_irq.h as none of its interfaces is used here and
> order the includes in alphabetical order.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

