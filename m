Return-Path: <linux-pwm+bounces-6975-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AE5B1D17A
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Aug 2025 06:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9BAE725FA1
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Aug 2025 04:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707681D5CE0;
	Thu,  7 Aug 2025 04:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMau9Pfm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0777415624D;
	Thu,  7 Aug 2025 04:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754541210; cv=none; b=Cnn1HNSCNuZ/mABtAvzpAE67uBcBrKzaFVBoVbrBxntyTxWL5BUJPfU5zgPlGpbWR378fWmvmYpRaRqTYTELnhqGUo5qMIPVcA/OfMt4ARyYZIvGQhAmV0Ra8kOyJdLuXcWZ1dUgyVBB3G9Gf5+aINsp9I9KmqzBdiWYZYAQzLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754541210; c=relaxed/simple;
	bh=cbiPNIRxJ0+TPk8XHjQGiCTC2gFsZ7Bja2SpJghvWS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4CDqAKR87XrwI6cjuKymoLpXLACXaY6QzU8vFizVLnVHI78Wcs02pJzLAClvUTp5v+l9SLpXe2CZ9Xt1FR7tNXRchUqo95Lvsyi8H+xBCzGXsj/pp8sHJWUABGEsRCZmf3EYH73xFpdqxMQ2OoHWaEV36J1bdBB1iPP+dVE4EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMau9Pfm; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76bc5e68d96so524199b3a.3;
        Wed, 06 Aug 2025 21:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754541208; x=1755146008; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z9RPuX2Cey64XT1m8nGtJ8B2vs45y2EWTHKYflCfe/k=;
        b=bMau9PfmXpV5bpGmJxIlTZvBndaoBgcntJfTbUyEQV7rVBdy77mtk8yzLuvOTpLYw5
         JrZM09xTI8zxM5nmFWNEGJ6Fih2PZJOZMo8jNLHLSK4FVmyD1vRCGrzbPeFChO8AlV+c
         Lb/92VZK8ELIOE0/bO8kV38fZ1deoLMv4YonxKfI2pQKUl7zYxABHokdRB6QyV+J5aol
         Q60lUTMF1ycE/OWHR6rzQnT4tQI3LaZkTu1KtYq72Y0GbHAiZMjhBOY8hS009sgQU3zR
         0bHQgFjp3EyoEZwmp1aA61uPEoTYe+dfM1G0/Pv0pibuD1p5BMdf3HcBPxTbnm/zPABt
         tWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754541208; x=1755146008;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z9RPuX2Cey64XT1m8nGtJ8B2vs45y2EWTHKYflCfe/k=;
        b=Pmbuv6iK8y4WPctVmg2kdE+qJaqFpQxgjJkXaCFTsXIUbMsB0Qj30McUhDwqxVfSXL
         AEH6YqTpXEhpX77QNtUbZV0BNvTOBP3EIgS2EZU5zJe2p2oNI5Sql8ZXkWou4/Sry/Fd
         ABQrRGjL/H7UQ3XpMF7H+fM3wapXWj6OKB7xcHzbapwJBgzcNHfhthJzNwz0I5tP5Bo9
         XhL7c9jS6Xwt4ZVk24GFvgVxcYKYk7VFzaE4ezmYp82vw3gbVEa4uYvP5FTjIQAgkNzm
         r/mHhoY8xUJE4vs0m4iv8So0LfckMxUBtE4hRNTj9p+6fOLa1LqTSvnQIO+w7v96FlDd
         JUWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUitVle5KdMtBe5qYWwSQQCuTt8iul1/PZpFP/I/9AIHqJG1wIGzYwQfMMRENjJaubocHpMdsLVeMVL@vger.kernel.org, AJvYcCXd+El9R+U+Fi/CNVjgDPq190oTpXXS6MrdydKMtd+BKKi4352KZQz/aKwm5Rv5WtuaAcfkq/KNIut4jA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwifSduo+UomWBYV+59D6ArLmVTc2qTwQSdmFBBXMyh1MICee4q
	8TnA4S4t5m/fNa0LVQyxI3u8CdB6gNwu5KGpv7HvGrFDt3BMomhaI/QN
X-Gm-Gg: ASbGncveFBSgwhGtEcOD2oWhGJfGkc8G1Alhvp8GGEm4OYZsx4nuuiJxfXWvELNAU87
	ssSq7A88X+BP9zjeEk3vRDbvm32Qm1sqMnmeN1Hi+Zeh1Z+uinZv3bbfMb4PPpVW/mLPeJ9qXiS
	cUPl90ZTFjuwPIRh4ziK+2iS63L4B99yEOKdB8OlGX0EBk02UwPtlVfMJSeurNv1PE9AQ3SZBXB
	U0i8CG1VXx9NaTkozPs9ErK67JT+oCpbzTMBUC5k8XRKZMHxiyGailbWVwV3PR4aV+1YnzgpQ4r
	cM2dhEpNVWGAt7w83u82u2o5Z1St1kfssOxpP6zIN7HOX2v/3B4NwjXpElq2ZKo15qtK4mF1A3x
	8sElAeGdlA07o5IHCa43Tf77JipEoIe1MaA==
X-Google-Smtp-Source: AGHT+IE9HgAvb08HTM/crqgnI+qCFrfYWX97YigV8hs+Qk95YqDkSXjYt97lMSarUud2kNrlpFoSew==
X-Received: by 2002:a17:903:120b:b0:240:2efe:c384 with SMTP id d9443c01a7336-2429f2fe7d1mr72582435ad.19.1754541208143;
        Wed, 06 Aug 2025 21:33:28 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:1dc7:76a8:a227:b1c7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32161282ab6sm4340573a91.26.2025.08.06.21.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 21:33:27 -0700 (PDT)
Date: Wed, 6 Aug 2025 21:33:25 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] Input: max77693 - Convert to atomic pwm operation
Message-ID: <wfdklejfruh4m54kmekyu2xssd6uss7es2nyvhqhki5zgbziwk@6bounno2zauu>
References: <20250630103851.2069952-2-u.kleine-koenig@baylibre.com>
 <w3tkxxkqr2kmri3bz5m34dzw3hfvkqou3zbww7kwjdg72o7kla@ty777ynf26qr>
 <23ddfd32qebfzb4qftxih3mwpymghlezdv5u63qhxhqthpbxpz@u7f4tbihsfop>
 <yafw6oi62ckqgz7ur4idua2r2sjyxnfomc7h2v5w6tthqwu334@5i6tdfumtj5b>
 <sl3jqe36dfxfzblposdtkvlgalc4ydixpqkfmn7gc6hcjfwmqn@7bex3mxwjqyy>
 <zxeva5asxre7oc6vakfoyiehegt5c4i7qwaeue5woxk4xir3di@thcg7lyadvn3>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <zxeva5asxre7oc6vakfoyiehegt5c4i7qwaeue5woxk4xir3di@thcg7lyadvn3>

Hi Uwe,

On Tue, Jul 29, 2025 at 10:04:06PM +0200, Uwe Kleine-König wrote:
> Hello Dmitry,
> 
> On Wed, Jul 02, 2025 at 08:02:33AM +0200, Uwe Kleine-König wrote:
> > On Tue, Jul 01, 2025 at 11:06:50AM -0700, Dmitry Torokhov wrote:
> > > On Tue, Jul 01, 2025 at 07:49:22AM +0200, Uwe Kleine-König wrote:
> > > > 
> > > > I had something like that at first, but didn't like it. With that
> > > > approach you have two places that have to know how to set the PWM's
> > > > duty_cycle. Also I think the control flow is more complicated.
> > > > 
> > > > I considered renaming max77693_haptic_enable() to something that better
> > > > matches what it does in my variant, but max77693_haptic_configure() was
> > > > already taken.
> > > > 
> > > > But that might all be subjective? If you like your version better,
> > > > that's fine, it still gets rid of pwm_config(), pwm_enable() and
> > > > pwm_apply_args() which is my main objective.
> > > 
> > > Yes, I agree that it is subjective. I know that you do not quite like
> > > the version I posted, still will you be OK if it is attributed to you?
> > 
> > Yes, feel free to apply it as you suggested.
> 
> As of today's next that didn't happen. Do you have this patch still on
> your radar?

My bad, I lost track of it when I reshuffled my queue. 

> 
> This is the last driver making use of pwm_config(), it would be great to
> get rid of that.

The patch is in the pull request I just sent to Linus, hope this
unblocks you.

Thanks.

-- 
Dmitry

