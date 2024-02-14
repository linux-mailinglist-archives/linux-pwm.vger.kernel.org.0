Return-Path: <linux-pwm+bounces-1504-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8736F8551E9
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 19:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D401F2A079
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 18:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC1C84A3E;
	Wed, 14 Feb 2024 18:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sn2Uqgs4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDB57D3E1
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 18:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934598; cv=none; b=PY6nSGflDQhxX7zwP+gT7sjyPW9N0WX5JSAXjWj6S91FHJACQTr0hFiRpuK2ZUqOV3cBDBDiGiG08VeeXg1lom3JtU6ElH09Dh5Sz3xjXHtskGBERTsO+Gp10lxrU789wpvZXOrWA39jL9jYYupi4V5N8CL9kCVifHwY6pZZP+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934598; c=relaxed/simple;
	bh=eNeI8ldeOXVyYU5y4G5uGvLkA49GeutfdVfIPxaJR+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dyHUMagffnZF6DcqIDsWyCqwmoJvI+4lJDyFA8kSdDowquJraSF3PCTMyp02JbeJsbVo0m7OGVugIhlVdD6IwlK+f+tBuVP3RT0IkzMChtJgAMcGXO9MGEZPhACC6PjbHQp+29aIbcFO5tDP+G+JJcZoXG/WA29Odjgv7cYBCvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sn2Uqgs4; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33b2960ff60so650882f8f.1
        for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 10:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707934595; x=1708539395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNeI8ldeOXVyYU5y4G5uGvLkA49GeutfdVfIPxaJR+U=;
        b=Sn2Uqgs4FcrQ09BvvMoYzg8MFewyHIrrXOc7h4voWF5BpfdgzK4yOgJPge474e3NHp
         aRU1V078b5+uz98GCrte3fznSxX1i70H1XbuYLSaGX16CuCoMgHAh81IV8YE9HQJm5Av
         tekCzCd0A74Knuci/Fsk6/u81XrN5rMIE0F4r01G3O91QRDP+ePhCL20NoHUKtRW8UEh
         GAFQu33dQs0xkHeWTEMwBsfDKZ+CmOB6fgbXJdhniU0sotXtDkn+8qySXTxGfh7jg/0/
         dX4TwNyl71EPuQe5YwA4uAF/3okYZaBkkh6/CYcsPzgBmpM50UP1Whjkv8oyqpNkm2Ir
         SkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707934595; x=1708539395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNeI8ldeOXVyYU5y4G5uGvLkA49GeutfdVfIPxaJR+U=;
        b=hRtphUg3FBzCPzPZIqofNYRnDLtrgX+Sa7i8IcsFICmcAhFe0zMk89mfizgeXY0ptk
         h+qaT2P11TvvkMTCIQ/nSkESrCum+3TL1s3uuFFNDZ1rXi5oy/CsQgaPF8akHP5qAzF0
         OPQbTd1rFDuqmPjTSe9U6CBzyL+h4GVk/p4vMaMQHEkF1nQdi/9o0XrQvzPo9ahEH0uP
         kSEnj7kqR3zrX0NM3TQ9+oI/KXB5aRouAkCOw06ZLIZ2ND+qBYZBmnSTLFb4jwtpzPo4
         LQpkqZtcoKIgai8VKCefBy0B1IRY01eaL/YurcxPNJGgW+oIuSs6ASjd8TkzXJBqNdwm
         lCzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI5MuhNbsqm80/drWCDgVXV2GVHAsngDLLL6NLy6EQXDu+oExd6JzDwCACUjA25NkXLEYVTKvUbU5m8kTAyzNSa9P5ITfI2zKe
X-Gm-Message-State: AOJu0Yx9N+CEQCIupOWiwun4umxvKM15f6S9TEmDUk0vz47/Nga4ECLP
	1JjsVXhrgL8E0hYQci4C6OwD9nyQAihTozHgqxVVCyyKr2rD+SL7
X-Google-Smtp-Source: AGHT+IHNgm4mA4NeVwoXy2ia8eMk3+9YX7+zGJaL84z5AExtp64tdZok98OjS2DaHI8OFZo2AYSpbA==
X-Received: by 2002:a5d:40c8:0:b0:33c:ef57:ef02 with SMTP id b8-20020a5d40c8000000b0033cef57ef02mr2504331wrq.17.1707934595160;
        Wed, 14 Feb 2024 10:16:35 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id k3-20020a05600c0b4300b00410b0ce91b1sm2610954wmr.25.2024.02.14.10.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 10:16:22 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 linux-pwm@vger.kernel.org,
 Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 kernel@pengutronix.de
Subject:
 Re: [PATCH v6 124/164] pwm: sun4i: Make use of pwmchip_parent() accessor
Date: Wed, 14 Feb 2024 19:16:19 +0100
Message-ID: <2717935.mvXUDI8C0e@jernej-laptop>
In-Reply-To:
 <3ddaec73f3abefb45625d0a469026fa8d13da8c0.1707900770.git.u.kleine-koenig@pengutronix.de>
References:
 <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
 <3ddaec73f3abefb45625d0a469026fa8d13da8c0.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Dne sreda, 14. februar 2024 ob 10:32:51 CET je Uwe Kleine-K=F6nig napisal(a=
):
> struct pwm_chip::dev is about to change. To not have to touch this
> driver in the same commit as struct pwm_chip::dev, use the accessor
> function provided for exactly this purpose.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



