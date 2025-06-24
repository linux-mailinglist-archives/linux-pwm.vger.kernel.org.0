Return-Path: <linux-pwm+bounces-6519-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A88AE6EA6
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 20:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 764CE3B597B
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 18:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1C5226CF1;
	Tue, 24 Jun 2025 18:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="eWj2z86e";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="eWj2z86e"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EEF2343CF
	for <linux-pwm@vger.kernel.org>; Tue, 24 Jun 2025 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750789935; cv=none; b=kqXwh/P+IbePGoyKFKPJo1DBh3MW6ENlezWNFglPeXCvXgyFcnXhVMW45TqYao7bZj7tNHl6gKkvkulRW4EdYV+iIMDffWgFm4ncdRAfptfEQWn98aKg1r/R8pGr6n7faZOqN8sEKWqbJ4VyvUcbGNpmJWYFkau4NcShDwiPVKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750789935; c=relaxed/simple;
	bh=e033+EOrm+ZQynE0f3rzefdqZBwm9MyxhSN1QecZt60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XkomnCEfL1RZN1Z5rY+5npn524JllHAM2SGcTGcOwPN4dkpYCdqE1pCGpu3ixKkp0Vmmaat2GUK0LVeAs8NjOVUfhYYPwhOa7ErqEiRI+y3rVq6YNx47XQZJGpbmHQRyPkTc5GOBOej0Ym4vxpdTfMyX0ofi75xf3eTViG6H56Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=eWj2z86e; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=eWj2z86e; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1750789331; bh=e033+EOrm+ZQynE0f3rzefdqZBwm9MyxhSN1QecZt60=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eWj2z86e6QU2vGPgFshbKs+3wBYTgmLCJv72AR6PsONpdcNxSLV4JHCEu4Kh3f+Yj
	 LqPJU8tB/ZJ6PMq4Rluqp9b4rc+nTnqmNv4CycAufQ2cDJB1zpPaziaREmgYIK+INs
	 gTOWZZGeQTrIU3IYG1uxbjHX75wYh9mDJbaO1Gc0ofWqFt/pQUbxqpQf4T0VorqQAk
	 UTSzulknzcI4g8WxJTKrGb2fNHKR32X/fPcxVLAIEuB2OOuQa509KJSDE1Rhij4YI2
	 J0LN6mVGCq4Cg0AQ06/nPkYu2QBAxqmZrO7kwALnDEO2Nw/HdBNE+lHRHLFax6k0qd
	 sSf+S0Wdzksfg==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id B9FBC3C427D;
	Tue, 24 Jun 2025 18:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1750789331; bh=e033+EOrm+ZQynE0f3rzefdqZBwm9MyxhSN1QecZt60=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eWj2z86e6QU2vGPgFshbKs+3wBYTgmLCJv72AR6PsONpdcNxSLV4JHCEu4Kh3f+Yj
	 LqPJU8tB/ZJ6PMq4Rluqp9b4rc+nTnqmNv4CycAufQ2cDJB1zpPaziaREmgYIK+INs
	 gTOWZZGeQTrIU3IYG1uxbjHX75wYh9mDJbaO1Gc0ofWqFt/pQUbxqpQf4T0VorqQAk
	 UTSzulknzcI4g8WxJTKrGb2fNHKR32X/fPcxVLAIEuB2OOuQa509KJSDE1Rhij4YI2
	 J0LN6mVGCq4Cg0AQ06/nPkYu2QBAxqmZrO7kwALnDEO2Nw/HdBNE+lHRHLFax6k0qd
	 sSf+S0Wdzksfg==
Message-ID: <02d0b071-435e-4f72-ac57-40d883e5db27@mleia.com>
Date: Tue, 24 Jun 2025 21:22:10 +0300
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] pwm: lpc18xx-sct: Drop driver local locking
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
References: <cover.1750788649.git.u.kleine-koenig@baylibre.com>
 <4f7a2da37adbfe4743564245119045826d86eca6.1750788649.git.u.kleine-koenig@baylibre.com>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <4f7a2da37adbfe4743564245119045826d86eca6.1750788649.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20250624_182211_774414_359A9DC3 
X-CRM114-Status: UNSURE (   5.45  )
X-CRM114-Notice: Please train this message. 

On 6/24/25 21:15, Uwe Kleine-König wrote:
> Both mutexes are only used in one function each. These functions are only
> called by the .apply() callback. As the .apply() calls are serialized by
> the core since commit 1cc2e1faafb3 ("pwm: Add more locking") the mutexes
> have no effect apart from runtime overhead. Drop them.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

Thank you for the change.

-- 
Best wishes,
Vladimir

