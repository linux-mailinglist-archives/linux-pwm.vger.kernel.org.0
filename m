Return-Path: <linux-pwm+bounces-6679-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C472AF0281
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 20:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 299F97B26CF
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 18:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1233826FA53;
	Tue,  1 Jul 2025 18:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpiORJaK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E4B1B95B;
	Tue,  1 Jul 2025 18:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751393216; cv=none; b=job3EQ9oosZta7qu4Liku62csExS4duEWL0zBOWVcCIKPt2BtEgMTJSgGlhL8GRiFieRboMLnZdMWz4gRAh+LoognSvc9Ja6eHL6zq5wV4Hlv6va1xrTJ6ruOBK6a17fBsV9I1n7zdVYsaMChEvzwnObhw24qrkTV7cP72Dj5WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751393216; c=relaxed/simple;
	bh=O1c8H0EgHqdHsiZJ676k/FUNv6DSEhEGjPvkRGdolkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3HUyF2uZNwb0i4mNzlzYdqX4JgpTOmj6eYLGECEwuOXnaXr+yiZPkOjYhHZgpMrRzRPABCAVbXaN7G2SrkpD4xTVAoj8iePH8DUiOLqkHA12YRo5cWjUCKbOaN9dyOY0daPQfw8d6sUT82Q2gjOUfD8neYGZEtIV7TjuXoCqD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpiORJaK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234b440afa7so60609685ad.0;
        Tue, 01 Jul 2025 11:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751393214; x=1751998014; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UTT28K9EZ5r0Ef5qlS/YiD+tvEf0MNm8qmQ288CIOGE=;
        b=JpiORJaKASKOR8cp+UXlnRNnnlURVsB7JvRTGtDL8ricAe5yp77BRj63a2ON6Jfod8
         HNn+KTBC2XQgvU6E2fxUXPRIBQ9n6Kx6kdWZ9/OBB7WOj5Ic6/IxiVtej77QSoSxXCTc
         zy38wSomJjl7F/7yx44tZh08d22J7QJ1h2jIT4BlF+Qyz4KyU6RyAaSdGvdb9TVlp4tM
         Xgr6DAoBkurwSmZFGSKxxKb8Hc8IjE74NPIij5JNtStwmUv/r19xXHlupQAJtL71kw1v
         FvO8qIFv11xYh8DYlkrDbpoCkqE7le8WNPapXhUbB+GX3gRgSgmf1snLj/XOQUkMv4Nk
         tAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751393214; x=1751998014;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UTT28K9EZ5r0Ef5qlS/YiD+tvEf0MNm8qmQ288CIOGE=;
        b=uTgzjus+l2zAG+tv6fuR0ADQGg1FM+Scnv6IVHPH2CR8sX9XK2z7oiyjFfh54FUrnm
         8nVAXrbx/t0fJjr/DbobxZFK9dPfKJIg11wQuwFsmYCO0mJEBskI7l0EzhEGIDy3svfp
         eMrqOcv9jDBRZu6o5/HQRKwiQskK3wB+8D0K1rPqOddIR3d4LiIUrmXgYOTBpg2uGn2N
         cmgZHMWBZcsp7MEPPc2tnLf79WFbd8hDoCQ7ng+7F8rWxaXlZPxKJmDCEuSaxgNaZoPZ
         3ZXDJkvRwMv5sZisLaI9P+ql7uQK0RBorWQHzXqjaZpG6KwYP/abp/vR0Bau2481+61w
         Td0g==
X-Forwarded-Encrypted: i=1; AJvYcCUNVX8Abl1oJm150RWygqDrIAPi+PlwsF3TQUvSLek90zVcVCAhEFYY15zG6OxMeR4Ln7fMqkChlbXthw==@vger.kernel.org, AJvYcCVoCCb4tBlCqdvaMPLBGm2RfvOEpXji7d7o5jA00WyldXpwTj1x4ObD+t1wbNQxzJdWzNLncs9yHVRi@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5/J5XMytWj1806qbPfIWoMaYcMGJunHknNpxYkRhLddbCvbgO
	04AeJUHyGyP/qJlwbokiF/FmZxoOBAfgURcHQLGDTlLfhlQuuQEZEpk/shpkSw==
X-Gm-Gg: ASbGncu8UfBHWNm0B4tkjDtjhnUrXuXr1d+urzR4fvtALyUPqsKSuSm9ZOt3wAS50S8
	f+IE2V51o6/Jw3CwlsU+drmWM9kWld7Ifp90fmUPQXlc6WpxTjjrCYj1OVqNd2umqWiwMMGiyuN
	DfphAyCrNq2fbquzm8ZoakmOyjPETB6r+ueNjWFGIHtW01YJEfykmJxQP7GbkOZCDa0eGN64e1O
	2D/6AH+a1mryuHgHQl05gIQvsoL/cOvzYIRV3yHBeydAB1sJgJwzh71bKM/p9tPMlpU5esJRkxk
	tbZKIcfgadUS4lDwanEOsUbv80pp0eIPip19rDxlZL3Q9ruNUYBvbW05wViPQzc=
X-Google-Smtp-Source: AGHT+IFBwuo1J8WSmGCQ3sis6Vzy0ra5CKZf0c5rCvt2dI8ZGCgJOKOT4chBoq5R1dPOWW8Gi/Xl0g==
X-Received: by 2002:a17:902:e746:b0:234:d292:be7a with SMTP id d9443c01a7336-23ac3bffdbdmr270727605ad.1.1751393213757;
        Tue, 01 Jul 2025 11:06:53 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:7bb0:b5bc:35bb:1cb4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e31da436sm10897813a12.57.2025.07.01.11.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 11:06:53 -0700 (PDT)
Date: Tue, 1 Jul 2025 11:06:50 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] Input: max77693 - Convert to atomic pwm operation
Message-ID: <yafw6oi62ckqgz7ur4idua2r2sjyxnfomc7h2v5w6tthqwu334@5i6tdfumtj5b>
References: <20250630103851.2069952-2-u.kleine-koenig@baylibre.com>
 <w3tkxxkqr2kmri3bz5m34dzw3hfvkqou3zbww7kwjdg72o7kla@ty777ynf26qr>
 <23ddfd32qebfzb4qftxih3mwpymghlezdv5u63qhxhqthpbxpz@u7f4tbihsfop>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23ddfd32qebfzb4qftxih3mwpymghlezdv5u63qhxhqthpbxpz@u7f4tbihsfop>

On Tue, Jul 01, 2025 at 07:49:22AM +0200, Uwe Kleine-König wrote:
> 
> I had something like that at first, but didn't like it. With that
> approach you have two places that have to know how to set the PWM's
> duty_cycle. Also I think the control flow is more complicated.
> 
> I considered renaming max77693_haptic_enable() to something that better
> matches what it does in my variant, but max77693_haptic_configure() was
> already taken.
> 
> But that might all be subjective? If you like your version better,
> that's fine, it still gets rid of pwm_config(), pwm_enable() and
> pwm_apply_args() which is my main objective.

Yes, I agree that it is subjective. I know that you do not quite like
the version I posted, still will you be OK if it is attributed to you?

Thanks.

-- 
Dmitry

