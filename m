Return-Path: <linux-pwm+bounces-7237-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B47ADB3FCAE
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Sep 2025 12:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454D3486445
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Sep 2025 10:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E372F360F;
	Tue,  2 Sep 2025 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApSYHyaf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF752F068A;
	Tue,  2 Sep 2025 10:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809397; cv=none; b=gTBPEtkBvFpj/eW6k3wZwAg+HNoRynYa8jtNLeCfKFS429xRtxxVuLD4NiC6/yu4mG35L/dXyCIjDwSmELJfGCxn9pBM/Q4TTKSzsyBTTfsA3NCF1qbeOrlZ5iChvi8fOwg7milXK4WQohEnQawvy3no3XFhnmvtU1HzvaXRCQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809397; c=relaxed/simple;
	bh=aLYwCVcjgK+Ykfa6a4sTh95sU5K4KlPUrOioPHSSVUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVWMT3aA6PvIDyD6mKRcoDQEy4oqFF84hQFKwY01siS/7jFdWsyvPvwj3HLB7ozk3W2XDHDNNm9TLYtDfvftJT8VbUtEf4oDopqzkoEFdX/XHF4GyERts+dN8OBRicu21NEFOxCEfR5X3KByDJuyx0KDtak61g6oytudREepMo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApSYHyaf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EAFC4CEF7;
	Tue,  2 Sep 2025 10:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756809396;
	bh=aLYwCVcjgK+Ykfa6a4sTh95sU5K4KlPUrOioPHSSVUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ApSYHyafSOLKGR+yfxcc3judZLx8wLkmz1h8TPBOIn+XAUVpmx4fvPPUV3WL5HUm1
	 koGpuRdxldC1LV2PHrjvCDA2NwXeS6VUub6Wm0z1Xi6MRu6y9kOUfc1Ebw40hTEbTC
	 Uu3yjxRBmLzLckSAGeouhw/1Yu10CsqvRKHJjE9DoVy5upVniAN63ei77ETj5ZIT0s
	 40ntXS197fYo7dKrmypM/m76LLsCs2GBjouNaZlNNdKm44ORHeeYSlCjHEgHg/0Y3a
	 2vIJXF0WUyv787A2iTqiB+X0ibiwzXAi0lozNAVIAgDFc++kWLm8kqGLKDCagYgHpG
	 XTPuPvWwwvG5A==
Date: Tue, 2 Sep 2025 11:36:32 +0100
From: Lee Jones <lee@kernel.org>
To: Daniel Thompson <daniel@riscstar.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Flavio Suligoi <f.suligoi@asem.it>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/2] backlight: mp3309c: Initialize backlight properties
 without memset
Message-ID: <20250902103632.GH2163762@google.com>
References: <cover.1751361465.git.u.kleine-koenig@baylibre.com>
 <14514a1b0d3df6438aa10bb74f1c4fc2367d9987.1751361465.git.u.kleine-koenig@baylibre.com>
 <aKLvaP55PIVhyFSc@aspen.lan>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aKLvaP55PIVhyFSc@aspen.lan>

On Mon, 18 Aug 2025, Daniel Thompson wrote:

> On Tue, Jul 01, 2025 at 11:22:37AM +0200, Uwe Kleine-König wrote:
> > Assigning values to a struct using a compound literal (since C99) also
> > guarantees that all unspecified struct members are empty-initialized, so
> > it properly replaces the memset to zero.
> >
> > The code looks a bit nicer and more idiomatic (though that might be
> > subjective?). The resulting binary is a bit smaller. On ARCH=arm with
> > an allnoconfig + minimal changes to enable the mp3309c driver the
> > difference is 12 bytes.
> >
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> 
> Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>

Looks like you cannot send tags from non-related email accounts:

NOTE: some trailers ignored due to from/email mismatches:
    ! Trailer: Reviewed-by: "Daniel Thompson (RISCstar)" <danielt@kernel.org>
     Msg From: Daniel Thompson <daniel@riscstar.com>

I'll add the tags manually this time.

-- 
Lee Jones [李琼斯]

