Return-Path: <linux-pwm+bounces-2244-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE188CFD93
	for <lists+linux-pwm@lfdr.de>; Mon, 27 May 2024 11:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BEEA1C21246
	for <lists+linux-pwm@lfdr.de>; Mon, 27 May 2024 09:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2026D13AA42;
	Mon, 27 May 2024 09:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OwZyc81o"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973C313A896
	for <linux-pwm@vger.kernel.org>; Mon, 27 May 2024 09:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716803799; cv=none; b=DLTXkL4ZoInjymUtvjDBiUSX6GiugF3c7eH8u6whx0eidGXGO1GRq9/Mps7SUinBPKbT/0tJxst6ineY4+FN5MZ273Ihai34z/w8LtnirW1UsWZ2ZIqb8ZWHFDjH1DD3UCyLmQHTOFLfiS/AThn6FSc7m3OXENNWYP4DirKWUCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716803799; c=relaxed/simple;
	bh=h5jXgRKsQkIcgfD97Q5AAMa9LZ0uTBSUY0djiFxnNdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X8u0+dDcbS29FBbldEWaiiDyn0bJsyzEGEmqIAcNfysaJEHgtUvKJnuigJiW8VPkbQvNCDgZ1+4OfMgqjslJ7AlenmULIp3s6lhuzdsUGtioCTW26zHw6g3HlSBngsEBIwjfrdbcfaQbpZ/XIE0VrHi+Mw36kQx7n8MLveI4A3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OwZyc81o; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-62a08092c4dso28918907b3.0
        for <linux-pwm@vger.kernel.org>; Mon, 27 May 2024 02:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716803796; x=1717408596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5jXgRKsQkIcgfD97Q5AAMa9LZ0uTBSUY0djiFxnNdM=;
        b=OwZyc81oHXBDnMV3uNMxqSlJRYsWOthjL5fZK2YxsR7yccd2ZaPUemN11Zc//VBDuP
         q9AvTGyyIJNE+1QaueCdotAutEG7/s8iHmMRbsK86csfjd9M8R7nyNw4BaTzTA5HU3rl
         N1QZHEkS71sCNIR3xJhqsfHfeff113hVZ2eN55ZbnFJ1nhZyQvDTA/olsEJZerJXHPxJ
         YOoaMzar9lZVfo51KpfQt5KH+Tjm10CX0mSJEctLWX7o0Vw0sbT/S2M450usXd8yrhvI
         zV32JlmgFfoYwIMJLlKssYQl/JiSgnvyEMd5XvYWdtgFaQme6118x9GE6blFTrpKfmas
         NAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716803796; x=1717408596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5jXgRKsQkIcgfD97Q5AAMa9LZ0uTBSUY0djiFxnNdM=;
        b=X2TZSsejJYB7GbBbWJ2FZpZhXM2OeSGBlPK6jdr8AKcngSmROuZ1YJDgopkPSN8NH2
         Bsvd+zTQy5rLfHvpjTvfQ1kx6PScYW4GV/gBy9J1vHu0Pg+H+52QFlh23/exurQB0+8e
         JdNf1VYLkTqiYgwmTmAMgLo5xkrVCfKlSRP9ndzlD08vm0h/aH7ngt9ewSNmK1CYy7sP
         edOqXmVc1xXzNzV4FVGqeoAax77SJeN0XqDEfXTtuzipR9gPoML7+Gv8UKF5TqTEK/UV
         9uh/6GA4uzSUt9fW6U8BLyPdnojy/QvIXnjaNX7HwC/kF/CHbAxj+zDcmwILlGs75XK5
         MGMA==
X-Forwarded-Encrypted: i=1; AJvYcCVI7iZEXv/iUpcD+Ctvs2QpCO06zwhcKjsiebyVZg7imMmDSWKUit7nkZrUq45efNuPIMiGWpIYE47ECcbgbJCBwdSZfsHqhZ1Y
X-Gm-Message-State: AOJu0YxZTe2eXqmZuavOC7NRTorkFK2UwK4AmRuvgzeoiJmwFlPvvDAB
	QJ+sQR2pH+7fWIoBdibLO1lBgdtIHnuf7zvhN+W0Za4RwMiE5mrKkaiHunwg6zGUMLWFErx5iUe
	hvRS25uST0y5TNbqk7PMJgSUKIe3jVQssyE0NwQ==
X-Google-Smtp-Source: AGHT+IGpccHoFCMTsrdaZe9Tm3wWZXSUyc/MWc6ba+P+ihM0RdYtqT8i31GHF/bZGJjJh4akODp67cOD7U7PAxqiLSM=
X-Received: by 2002:a25:c7d1:0:b0:df4:e794:21b8 with SMTP id
 3f1490d57ef6-df77225ad0bmr9332361276.55.1716803796507; Mon, 27 May 2024
 02:56:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204220851.4783-1-wahrenst@gmx.net> <CACRpkdYmOECdug1g2gYxjHZ-+Y040SR70UtDAgKD8yCb58Ob6Q@mail.gmail.com>
 <33d009cc-3378-42e0-8d40-a74a0b583a44@gmx.net>
In-Reply-To: <33d009cc-3378-42e0-8d40-a74a0b583a44@gmx.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 May 2024 11:56:25 +0200
Message-ID: <CACRpkdary+kDrTJ=u4VbSTv7wXGLQj9_fy7mv0w-Zg+eDvGXVQ@mail.gmail.com>
Subject: Re: [PATCH V4 0/2] pwm: Add GPIO PWM driver
To: Stefan Wahren <wahrenst@gmx.net>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	andy.shevchenko@gmail.com, Angelo Compagnucci <angelo.compagnucci@gmail.com>, 
	Philip Howard <phil@gadgetoid.com>, Sean Young <sean@mess.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 10:44=E2=80=AFAM Stefan Wahren <wahrenst@gmx.net> w=
rote:

> I could rebase my latest work on 6.10-rc1 and send it out as V5. I would
> be happy if you want to continue on that driver.

I could probably do that! Let's see v5 and take it from there.

Yours,
Linus Walleij

