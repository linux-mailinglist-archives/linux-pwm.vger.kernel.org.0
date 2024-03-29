Return-Path: <linux-pwm+bounces-1836-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567F6891FAB
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Mar 2024 16:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0822028A497
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Mar 2024 15:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C369E146581;
	Fri, 29 Mar 2024 13:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HssmyUaz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA521465A6
	for <linux-pwm@vger.kernel.org>; Fri, 29 Mar 2024 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711720241; cv=none; b=rWUfwufsqg5wa+CdxGxAGxwm17MJxhmxfm4VpxFrQQnsxS5oRSdz8/3T8cp2BFtpwPQUiASy1KNMBTNV7od+U8zyO5ZMJC0IdyQKCHZVXEVkkaLERKl7qaOvYsLypNIyLHVRBSzG203Rd7Dyc+Ce39c9mzHj2azgZlUH36dCJ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711720241; c=relaxed/simple;
	bh=k9Pz2wGjjLq/znd6nt6zLHxpUPldlGrUSAlgLnKAn7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dxk/fNGHzmjo1NELnvGYWnJbI++JKfRpSmQjE+a2OGX41gG0pqj8F2yHfj/ybucY2q/CTVSM8ebi3WUrZWH5JTkWfY+6jUM5aTqO01sOOPEOoOIs1yTurQ+KEZPynHk7x2JbQd8p0gs1YLD0sFF1IyKMR79jkKjcYWjk5pEbvFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HssmyUaz; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d71765d3e1so9306441fa.0
        for <linux-pwm@vger.kernel.org>; Fri, 29 Mar 2024 06:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711720236; x=1712325036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9Pz2wGjjLq/znd6nt6zLHxpUPldlGrUSAlgLnKAn7g=;
        b=HssmyUazSNhFqFvtvC+X6ciP8tk1VY17FEUN/AwKm4E+3SENv+HQzskRaZwrmCzq0n
         tjfurpk2OpFIxM47Xnokj8pIGNkOHG+ZWBALri+zy0O8kQ70GbK1rog2jBl3S1zYYtpV
         BKd48L3fCyfQEGjh2YB9ABoUs2IgK7WOu/eVI4siOffcY+I2dS1YxscMONCEUTg95Ct8
         4cHzu+LAg6ra54YzUXYqy+IJolcMsmhtT3HKw2fDWzzu4GmuVUP7/wuHwZy+EaYjHhLN
         x5BfTTiVqaHY8DhYDrHiqSvFpioHv7bnJPtFNmhzsZZNHK5k7Q/5aQPXAUk37kP+L1xZ
         dVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711720236; x=1712325036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9Pz2wGjjLq/znd6nt6zLHxpUPldlGrUSAlgLnKAn7g=;
        b=DCBVOnC3O4Ge2DVRe5ON539ltgb+8coRrIB46AH4aJOoPUoKyY3oAYiGn7MZ1Hxflv
         vHL3UXEwlafqq39TIz5z6GA+502JlwaEhDU46L/o2UmJ0u7DjIcP6tqJPCKoRYM6JgcU
         kfNIDZ0WIVdJO5XkhH/4zY+pNk2JN5fmxCq0vFaXP+Wf7PNSYMC6U9LtPX2gF+pKm3g6
         EcttOK85iC6F1zKsVHcwp3TDGPl6IDT88y80HUWIFQypAQOkB1jSpGmV/8emgH0b6nor
         +JXIE4oHd4BLJx94wgGovlm86tUcOrHNG3OfUwW1JVSHjKrGFVQ6rKjNdG5P2UuDJfLM
         FP9A==
X-Gm-Message-State: AOJu0YxI6U6FynZMv60zbdORUGEbFxpXjodXJbH9KxFDDOFpjqP1P/ma
	iwYlWQJjosjs4ID8z/fL5TSChlp1nU66piTadDvxIpMVMcdqPDJoS8fuzHqhPbKxPo1XLDwJyGT
	gY4NwYEWYdJKPC+RLtPHvdSVBSjrABN8y5ysYdMIIDKkIESE9Uz8=
X-Google-Smtp-Source: AGHT+IHx9H+eXzZ1h0kAXaPMAW/8x4mhedSNM5EI5+ajyiZQoyVbJkaAD7fzzTxwsCStxfleOOKAtHLOj1QYqyFotAU=
X-Received: by 2002:a2e:9c84:0:b0:2d4:5d3e:9666 with SMTP id
 x4-20020a2e9c84000000b002d45d3e9666mr1233664lji.45.1711720236626; Fri, 29 Mar
 2024 06:50:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329101648.544155-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20240329101648.544155-2-u.kleine-koenig@pengutronix.de>
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 29 Mar 2024 08:50:25 -0500
Message-ID: <CAMknhBFwKJw4ut4maTbF8DqOdymGiWfUM5b0EEGJOAauc57WCw@mail.gmail.com>
Subject: Re: [PATCH] pwm: Don't check pointer for being non-NULL after use
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 5:17=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> After assigning chip =3D pwm->chip; the compiler is free to assume that
> pwm is non-NULL and so can optimize out the check for pwm against NULL.
>
> While it's probably a programming error to pass a NULL pointer to
> pwm_put() this shouldn't be dropped without careful consideration and
> wasn't intended.
>
> So assign chip only after the NULL check.
>
> Reported-by: David Lechner <dlechner@baylibre.com>
> Fixes: d60bc2995732 ("pwm: Add a struct device to struct pwm_chip")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>

