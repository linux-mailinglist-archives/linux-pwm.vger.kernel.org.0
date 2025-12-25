Return-Path: <linux-pwm+bounces-7829-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61571CDE1B0
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Dec 2025 22:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65FDB3004F27
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Dec 2025 21:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E611E1CD15;
	Thu, 25 Dec 2025 21:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vSvkCmpS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A37222565
	for <linux-pwm@vger.kernel.org>; Thu, 25 Dec 2025 21:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766696525; cv=none; b=QARwDAqq/jeAC9siCRHO+gfjIOZJoevsZ1fvqKF15sBJyekbH+4BvAU71842ZAkvz7bYylfAvuyFFi452MaP8M8n3Fcx2BtNzKgC4/dRQEbNTQoZy8YClKIK0jd1geFIpe23B+JyDCeVRlwAIThnin4Yv/kK2p1hOftwvjy89e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766696525; c=relaxed/simple;
	bh=aJbAv5zbj/ZYzVbNshMVCyVaUwzSE9Jc8lGtmvvsp+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dMD1IPhDmnytKk2KnYvIhJf/YhDFt+sHWUjtrGE709RwttXGFx7o7FlJCTnAM4YpxjStK+q84ooaCCriJfAIcsBkA/CImVHTp0k3Yjj+FEGrULouBA9wIFaG39ScVFMCzNlo37SiMHMmNTObS/aa/7svvVQIYE4oP/sctxmbUac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=vSvkCmpS; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dch545QGbz9ssn;
	Thu, 25 Dec 2025 22:02:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1766696520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMtdOHD+O0P4b6dU0pzfx3LzPBzigA//PVKJi5o6JDs=;
	b=vSvkCmpSxL4Hyr0v2XUE06CKbUnh8D97qmLsBqww+Q/vRA09a6IqCd1Zqos8kfAtqXHBYC
	2DliY1ECMbBcBlWftjLLkTib7/IX0fvLUuSGJRnPFIeSN5gy8OCJXrHqXushPXEfGYTgIA
	5nSYBS9FV16jqn9wP2ecGk82OU2TdFbYbcBL+PV+n8SqHqp8C4oBtLjCJPTi6RJ2oCq7iO
	tNtUOzio+abTbZR5hE4QX9MY8GEyv+4t0cEtx0Rotq8nO2x75KMol5qhBAmxjRM2ibvIQT
	vHK22Q0hskirC2lxLbTcgkelLZPlCdE2vjpbZzt+i46bbG/ooTmUi+U3gO2IXw==
Message-ID: <37ad0603-45b6-48b0-b82b-4642b0e5286f@mailbox.org>
Date: Thu, 25 Dec 2025 22:01:59 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] pwm: argon-fan-hat: Add hardware dependency
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Jean Delvare <jdelvare@suse.de>, linux-pwm@vger.kernel.org
References: <20251103164752.533aee39@endymion>
 <05b5b096-33cd-45c4-9d9c-286d743c6916@mailbox.org>
 <f6c2d892b64057c079662e8bd64060d45c156288.camel@suse.de>
 <643bb99a-4d0e-47bc-a60e-208dcc151034@mailbox.org>
 <65639f87c800a1ffcd60d20bb9915772a0d7f456.camel@suse.de>
 <99609491-10bf-46f0-8178-a3c3d375b742@mailbox.org>
 <2l5iqxj2tgfvv4aszl74oatmlxwrfr4m7hy4y3lpybg2zhlrj7@p2ln65gnss64>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <2l5iqxj2tgfvv4aszl74oatmlxwrfr4m7hy4y3lpybg2zhlrj7@p2ln65gnss64>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: o8axe4h6um7n3jo73t976xrswhuxom9j
X-MBO-RS-ID: be8a51504fdf3ed7928

On 12/24/25 6:57 AM, Uwe Kleine-König wrote:
> Hello,

Hello Uwe,

> it seems we all agree that this patch isn't suitable to go in as is. So
> I mark it as "Changes-Requested" in patchwork and discard this thread
> from my inbox.

Indeed, the fan can be used on any arbitrary hardware with the right 
"rpi" connector.

Please drop this patch.

> Thanks and happy holidays,
Likewise. Thanks

