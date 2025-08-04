Return-Path: <linux-pwm+bounces-6952-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B55E7B1A338
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 15:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4481C7AAA92
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 13:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386A826C384;
	Mon,  4 Aug 2025 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4B75eB+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2AA26B955;
	Mon,  4 Aug 2025 13:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754314042; cv=none; b=d3+QMeH0GlFJYCn1BNS8j41gDlmvIjX6OsBO4SYZpQnTk+hTx9cx982wi0N+To41QDTS91V9igwtU2UWzk1bSHDq7E40Nw1bA0D6qtL0DwAGIYpJjZMcccYif+ULjpiriFohUTNozBDYMgw6lMuG3G4m1z9sz+ws9s075vCs2dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754314042; c=relaxed/simple;
	bh=0HpcXxVZIlcEaVB1NIukOwjT1SSDL2dg2xYzNVFQc9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=us9KS9EillxyVDCvzyHpulI44/IW75208XZAeLiHJgwuaYrxCf7cknEoB7RMn2UFhN2dvqDInLUuLJez5ZAJKiQVgbeDQP4Atg6q6UQtVDjSO6WTwRP8zcPCKS7bt3w9AIWP8UdLoofsKUc1+G2MGBVYaPH+CmX12+lc38Hi7ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4B75eB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1FBC4CEE7;
	Mon,  4 Aug 2025 13:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754314041;
	bh=0HpcXxVZIlcEaVB1NIukOwjT1SSDL2dg2xYzNVFQc9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b4B75eB+imckBwOM7aVBIuKE25ep/01n0T6A9iHBEI1lGT/k1tOQAiro/SUYXTNOf
	 gF57RRMZmybPQDkZ5zp2UvBQhkwhkOYRdZw490b7RzSCG7Fdr/bOqwZFOVFTNMFs+j
	 H6QJxcKN4tyRNKmqpNBMM2tjUrDPMaQCrnmvNMn1QnBgD4Z9Mh6EP7YSbHRVZ20cyG
	 NYxYtSN8ZlGCat07jXLIhHEJGSZaZgHggmxBGI1ZV1slvsQc8Q6UaKy80RgKrNPsJn
	 snSzkDiBA3lPt4HGaVRkM1HmW+pCwWfB2pXj4TD68CHICZtWRJUmN3sANzvznt4nLZ
	 oIcDJhLyHCc1A==
Date: Mon, 4 Aug 2025 09:27:19 -0400
From: Sasha Levin <sashal@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org,
	Nylon Chen <nylon.chen@sifive.com>, Zong Li <zong.li@sifive.com>,
	Vincent Chen <vincent.chen@sifive.com>, paul.walmsley@sifive.com,
	samuel.holland@sifive.com, linux-pwm@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.6 28/59] pwm: sifive: Fix PWM algorithm and
 clarify inverted compare behavior
Message-ID: <aJC1N93BVEVZjnWp@lappy>
References: <20250804003413.3622950-1-sashal@kernel.org>
 <20250804003413.3622950-28-sashal@kernel.org>
 <xgy4dio2oqwqow7k5nlbf2vgrx63ptmtsi533wad7pfa3v23tk@nzrkhb2nytpb>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xgy4dio2oqwqow7k5nlbf2vgrx63ptmtsi533wad7pfa3v23tk@nzrkhb2nytpb>

On Mon, Aug 04, 2025 at 12:45:24PM +0200, Uwe Kleine-König wrote:
>Hello,
>
>On Sun, Aug 03, 2025 at 08:33:42PM -0400, Sasha Levin wrote:
>> From: Nylon Chen <nylon.chen@sifive.com>
>>
>> [ Upstream commit 7dbc4432ea6bf9d709391eb57f1e9fb44e99845a ]
>>
>> The `frac` variable represents the pulse inactive time, and the result
>> of this algorithm is the pulse active time. Therefore, we must reverse
>> the result.
>>
>> Although the SiFive Reference Manual states "pwms >= pwmcmpX -> HIGH",
>> the hardware behavior is inverted due to a fixed XNOR with 0. As a result,
>> the pwmcmp register actually defines the low (inactive) portion of the pulse.
>>
>> The reference is SiFive FU740-C000 Manual[0]
>>
>> Link: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b16acba_fu740-c000-manual-v1p6.pdf [0]
>>
>> Co-developed-by: Zong Li <zong.li@sifive.com>
>> Signed-off-by: Zong Li <zong.li@sifive.com>
>> Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
>> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
>> Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
>> Link: https://lore.kernel.org/r/20250529035341.51736-3-nylon.chen@sifive.com
>> Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>
>Please drop this patch from your queue, see
>https://lore.kernel.org/all/52ycm5nf2jrxdmdmcijz57xhm2twspjmmiign6zq6rp3d5wt6t@tq5w47fmiwgg/
>for the rationale.

Will do.

>This is the fourth mail of this type I'm writing. For the future: Is it
>enough to raise these concerns once only and maybe even make it easier
>on your end, too? If so, should I better pick the oldest or the newest
>base version series to reply?

Sorry about that. Just replying to just one of the mails (really doesn't
matter which) would work.

-- 
Thanks,
Sasha

