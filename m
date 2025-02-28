Return-Path: <linux-pwm+bounces-5019-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5D6A493BA
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Feb 2025 09:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545F718922A4
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Feb 2025 08:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC762512E3;
	Fri, 28 Feb 2025 08:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bDiWInTE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE992505DE
	for <linux-pwm@vger.kernel.org>; Fri, 28 Feb 2025 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731985; cv=none; b=Nnk3Vvz7LLzVLPK2BV+tzNl0p0/QXjtoRo2bg18SIIAyD5zQmYq7RXjUQiPfwRa6TeEANCDuCI9/Y+16AxJNXwHmFiNgZ0s2FqCoKDPfSPhNcDBQE1r6syWKmbcRkc2xOqdwjl/k1WkiufmDKPLUBDAYh7f3Dmie4FHDpEh4RUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731985; c=relaxed/simple;
	bh=vXjiyibKKxM77UcLdQZUdVPFpQkCll0rLi8rRYGxZ3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t62idpoQEW6wqeuEI6jLS1irKLUzBMaFX0kFMAIqGr6hq4WoNsJkFoS08mabpmy0xuxlCNbSKIyHvk/Vohr5M3eL0B5GkfekZYS7EZN6VUCj3gNyR77NYrUiv1Y7Eoot+dRxMp4jmJcw26DpyTtWC8B/Dr4l33JcYHI10MeIKis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bDiWInTE; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5494bc8a526so920022e87.0
        for <linux-pwm@vger.kernel.org>; Fri, 28 Feb 2025 00:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740731982; x=1741336782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXjiyibKKxM77UcLdQZUdVPFpQkCll0rLi8rRYGxZ3U=;
        b=bDiWInTE2wLp8b29GnXJ1bKo9HpRSBfQ7dHgECNDrmHltAONJKsnNxAJU7CpwCd8hZ
         hJTP0+ZZ2KMkWHrns30xZ4LZxqTCy4zr1W/RyvJaj3m+ACIpiHGcJxyb/AZM3OILfgPW
         fDsoqMWXMNAj8osLKNKF3J1jXTcvFVSrMHIVrQzf9kbojD1MIJnL7RIWJ9GmnJJDhg1k
         3RCpgm03MNmr2lwwCQMY1wFKtgNd7D55SmlrtwhftBFvXJsGFDWoHr4WG3jTuynkp2c8
         KDbG5v4FXWuEW0o2VKfl/0a9V/gtw3w9JxOhz5lGF6tuikWKkEa8m/zLApsbvtRkgcGw
         QPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740731982; x=1741336782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXjiyibKKxM77UcLdQZUdVPFpQkCll0rLi8rRYGxZ3U=;
        b=g+lGo2gWp/VrQFwd6evcvx9iIMih/5XI9oPSIZ0GxBUSeAL0aW7f+R8/uh+JTuuf0m
         A83aeE4S9E3QLh6Ks4in/O88NuJG3wOWaktLQ4yS+Amyoxr6UuLoLtwYRPObvK0h08Gu
         Wd2RRzVk6VJCN8MAmG3k7CruXo4Waag6KHZzCx8YbhWrlOFKpJ073uxZrRc62g388n0f
         pyA1nCGkAd6JoS5EjYQOUDSHUJf5z5cPqQ2tc8dPku/q/gp8Ek6lj6J5MB6I7TBCZUYG
         9G+rTNuLNnk1nCYkMXKEiVWLiRMhrAgT6VL47v56doC1dfTWrYZ9y5SWibA96aPodfID
         KoCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtcv7zFhjG4pa/Tw5vH+O6sa66DaYdmfXFzsjWxgepsK2+MQkMuAutfA+mvaYT+AZVypOWbS3L/dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuYr9f1xZOtMuQtSsJDjoIZscnHf4Aw925Q68HU7J8SPo5IZBs
	hda+uUCDZmCob7wapxr1U/i/8+AbNs4mdqBZynR3OVoFASzPJU1zNs7YV+iWzkQwoQNgt2yuZdU
	rw0kqMKKUq/KBOymHZSe/DpECt9W6spZ9DxOtIQ==
X-Gm-Gg: ASbGncs/eLTFDalnN4G7XWXhMUWl3ESWyr89dKQEEKZaxx5xEc99G25xmAwDFg/uf1O
	5XERaAsA/HJusDIXYW5bBHIUgJSfdxvIBSM8aJ9K55imZhX71ZJPrZ0FmUkUmYh+HBPuT4OCntE
	JJRjNrTf8=
X-Google-Smtp-Source: AGHT+IGP05gd+tKAmHNLIYx59fJGUcXOpFn5E7WUbHiqgXJgfnuoO/oZlX/2XdBRPuKvDCHUORWy0P2hwCXTV/HE470=
X-Received: by 2002:a05:6512:3a90:b0:549:4416:df02 with SMTP id
 2adb3069b0e04-5494c332da2mr977914e87.41.1740731981662; Fri, 28 Feb 2025
 00:39:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227175132.3734524-1-robh@kernel.org>
In-Reply-To: <20250227175132.3734524-1-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 28 Feb 2025 09:39:30 +0100
X-Gm-Features: AQ5f1JpcWRmXsix253vEwz0xl8LXX8T28Ut4ONXhb1Jer9IAi0xNCTvsBZEZyVY
Message-ID: <CACRpkdZ8twhOH1T3cStuLsD7a7HME-wA9YzotmrhgXmy-zvPoA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gpio: mvebu: Add missing 'gpio-ranges'
 property and hog nodes
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, 
	linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 6:52=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:

> The Marvell mvebu binding users already use 'gpio-ranges' and have hog
> nodes, so add them to the binding.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

