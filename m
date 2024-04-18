Return-Path: <linux-pwm+bounces-2010-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0A28A9933
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Apr 2024 13:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E771F215BF
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Apr 2024 11:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4879815F319;
	Thu, 18 Apr 2024 11:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lz75U9xr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA21515E7E7
	for <linux-pwm@vger.kernel.org>; Thu, 18 Apr 2024 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441507; cv=none; b=RmMcrzmm2Z2bAPCWiAbkjsH/fgmqS+g2wb7lL2VymPakNC9XNJKcOC1d8YHdkhSj+dxuOIGNFWy322QDyvqc85sI8dVg/v1nED2+YKaSZa2lscCJn1+xZmhS9f1kvfuT3gVhrrUMQ3IjtgWCKeI92e9nMoPFj2tzMNZoZjbPIrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441507; c=relaxed/simple;
	bh=nC86tYRxqcAFYcUE3xNHvYSmqS9yxpHeryGhsn+Gyk8=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=N6R/LJDO96cd05bkYKNS3tHneetmt0/GH+dsQqxYuwtqPa6NLpx7axtNNxDUi0waWKrBlpXctqK3PGGtXQa+k0UW591q0fHl/jImB8zUyVUtPRGNa6iBDatOstY5W9ytD0AJvwyZe7m7WcKbGBfh8QYl8NB3h5HGreo1ayVhMek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lz75U9xr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-418effbc5d4so2156215e9.0
        for <linux-pwm@vger.kernel.org>; Thu, 18 Apr 2024 04:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713441503; x=1714046303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPinJVRyhqHu/v9gEjCPoBsAucy1v6DhCrUwhF/wDyo=;
        b=lz75U9xrrXa9SLXostP344+/EdNWzdVboGZoC0RG5otr/z4AWN6oa9usfcv3Espi9C
         S+Bbddw+cIt5kqQUiSl0sDTiAxtvEa5Tg+pkAAJoSt6EOLjlB0Y9CBzzX9Xb6blpIQUn
         dVKq8uwqLILauqDE68SYNoFyhzoeETqF9Yq/iM9XSWJCxAk0YZSnzQ6zs6dAI2imDIQd
         aapmLwKnhasDTW8M47sLQGnSz9WBAUPZBoNv1hQbRXdOgJ3POIjRdv/lzci5PD/kAc0y
         d4lnokn7a6SANv658b7cM1XY7G9BhgCeh2LjqgmW6NnJsuZjANT4pst0hncCZK7/uzyw
         a42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713441503; x=1714046303;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bPinJVRyhqHu/v9gEjCPoBsAucy1v6DhCrUwhF/wDyo=;
        b=LBBYzvDEqJGd7QXenve2Rmvr76x6G5AlHtuP5EBvJj7tht8a0qdYJ9GK984kmKoiyV
         CqM9oVymRPcw5ihtiQTob0ZbBHCwWqTnaOJcQIVJG+BOXpuUzxQ9yjR9XBiBrM4FHQCU
         agZmRQrvTHyLVP79PA0xhU1Fy4ibHo0lScBVEywvPnnQeNm0sjrPIVxveiyOC6qytzEz
         sDL9Pbv5EIYjMrNkO5CVWG1skkluvGOkYdF0jYI5/1wuiGFJaWHWcsjBKxbJoq2gHI3E
         0fQGv/VlpSsgrsUc+Tn9z3wyLU9KFSKwxm/VdfrZZnia47b8HeSr0V/ctPUgJByPWIuE
         Lcfw==
X-Forwarded-Encrypted: i=1; AJvYcCUW3Z5bKG59JrE3K8KXbvcL3qCsgpisOQ8X97P0Vvk0VtJpJmmp04jz1tLwsLcOyqhTLXUgaAx5ihlR3DCbd/m1BX1KYedozVeC
X-Gm-Message-State: AOJu0Yxu83+xa+VvtQJs5aACKMpHk/MCcOo9pcVlZxEUj2VQD5DYw57b
	UN2ezzLA2oyEN/AOPqr9EKZl5qm6pHz+qjNXUvmQlX1USrXWJ+HCw0Yax2/WlJg=
X-Google-Smtp-Source: AGHT+IH+ypEXEnKApXif3+7iV5cx+ug+vkoC+Z6959v+sNY3h0cmujX0MOmJ4M28zqLTPsn2KUXHJw==
X-Received: by 2002:a05:600c:a10:b0:418:792d:f8b4 with SMTP id z16-20020a05600c0a1000b00418792df8b4mr2480514wmp.23.1713441503081;
        Thu, 18 Apr 2024 04:58:23 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:5e54:be3b:baad:80ee])
        by smtp.gmail.com with ESMTPSA id k29-20020a05600c1c9d00b00418948a5eb0sm6286143wms.32.2024.04.18.04.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 04:58:22 -0700 (PDT)
References: <20240221151154.26452-1-jbrunet@baylibre.com>
 <20240221151154.26452-6-jbrunet@baylibre.com>
 <24ec3iiudmfapiosygpsvgu7kmdqe6csbkpuzx3p3sa4oyodqu@hshmbpvzhufb>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org, JunYi Zhao
 <junyi.zhao@amlogic.com>
Subject: Re: [PATCH v5 5/5] pwm: meson: add generic compatible for meson8 to
 sm1
Date: Thu, 18 Apr 2024 13:57:03 +0200
In-reply-to: <24ec3iiudmfapiosygpsvgu7kmdqe6csbkpuzx3p3sa4oyodqu@hshmbpvzhufb>
Message-ID: <1jplumc276.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Fri 12 Apr 2024 at 14:08, Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutr=
onix.de> wrote:

> [[PGP Signed Part:Undecided]]
> On Wed, Feb 21, 2024 at 04:11:51PM +0100, Jerome Brunet wrote:
>> Introduce a new compatible support in the Amlogic PWM driver.
>>=20
>> The PWM HW is actually the same for all SoCs supported so far. A specific
>> compatible is needed only because the clock sources of the PWMs are
>> hard-coded in the driver.
>>=20
>> It is better to have the clock source described in DT but this changes t=
he
>> bindings so a new compatible must be introduced.
>>=20
>> When all supported platform have migrated to the new compatible, support
>> for the legacy ones may be removed from the driver.
>>=20
>> The addition of this new compatible makes the old ones obsolete, as
>> described in the DT documentation.
>>=20
>> Adding a callback to setup the clock will also make it easier to add
>> support for the new PWM HW found in a1, s4, c3 and t7 SoC families.
>>=20
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>
> After spending some brain cycles on this one I think I understood it.
> Looks fine to me, I only considered questioning if the dev_warn_once is
> too offensive.
>
> b4 + git applied the patch just fine even without patch #4 of this
> series. Would you be so kind to double check it works as intended?

It does, Thx.

>
> BTW, b4 diagnosed:
>
> Checking attestation on all messages, may take a moment...
> ---
>   =E2=9C=97 [PATCH v5 5/5] pwm: meson: add generic compatible for meson8 =
to sm1
>     + Link: https://lore.kernel.org/r/20240221151154.26452-6-jbrunet@bayl=
ibre.com
>     + Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.d=
e>
>   ---
>   =E2=9C=97 BADSIG: DKIM/baylibre-com.20230601.gappssmtp.com
>
> Is this only because it took me so long to reply, or is there a
> configuration issue with the baylibre MTA?

I have no idea. This is the first time this is reported


>
> Best regards
> Uwe


--=20
Jerome

