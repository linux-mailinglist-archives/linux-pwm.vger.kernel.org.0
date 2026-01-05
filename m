Return-Path: <linux-pwm+bounces-7844-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED51CF34EA
	for <lists+linux-pwm@lfdr.de>; Mon, 05 Jan 2026 12:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06F52307897A
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Jan 2026 11:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9934C31961F;
	Mon,  5 Jan 2026 11:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VR38Sw6p"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191BD3A1E69
	for <linux-pwm@vger.kernel.org>; Mon,  5 Jan 2026 11:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611562; cv=none; b=utbShhNcl3vKw2//N+MjSsJQtXhTlNMfRWK68Jjti09DypOey8ywHLpsHCDjkqjsvXke08ewQ744abQklEVqRE/DnEfmKumbRE2UQvNlpZ0Zdu01nL1qnU6VHNBV1CWY2Hv2Cy45AOPSTPpjwytOUUsPcXiGWh2+VA3pYmMDjWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611562; c=relaxed/simple;
	bh=mNewUV/Qm/qNRfLwU755Kzj4Y9Ati2vGuno1/0dYI40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=CfvJJv2JUJI9uYxvTDP3kh3uo231osHe/efoc7qFQzJmQBd1OBKtGGIYqMovBE2Rv8LWbhiLfkGtSbbfrPLU8t+uOqcYUngET3XM05ljOMKWj/cod3rWTXXxoCox1/cHhxOswrol4GOQDTzrrK5tr/0tF3K/ApGWPQRMIU5IDDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=VR38Sw6p; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260105111238euoutp01f5d130feebf024ea9a33a2bbfe0b9d44~H0Vjb4iLY0853708537euoutp01T
	for <linux-pwm@vger.kernel.org>; Mon,  5 Jan 2026 11:12:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260105111238euoutp01f5d130feebf024ea9a33a2bbfe0b9d44~H0Vjb4iLY0853708537euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1767611558;
	bh=yA1n6l6IjZIIscNu9XWHxYEGswZKd9Ghbaim+fa1Ex4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=VR38Sw6pGienk3rtUSiA3YhH/tvrzbmXtAdHwvbrDUwPCXDpVZbj1W2gc8R1ikUFK
	 t1YH5UCfPpKpm77xLeJjNrQ6xb36TSsNw9BFr2ko5rhnJywwaS84OmW6VhX/Flbmdi
	 11fRZZpJ2luQLj45Wkwik8lKXMaAuyEEE1XYonbg=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260105111237eucas1p13c973db6e3ce59f5d118bb43278ee11b~H0VjCMJnf3267732677eucas1p1k;
	Mon,  5 Jan 2026 11:12:37 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260105111237eusmtip2dc2b37b9832a1d7167ae6abaeae52e23~H0Vie2HjC0892208922eusmtip2V;
	Mon,  5 Jan 2026 11:12:37 +0000 (GMT)
Message-ID: <9f45c967-4bb0-4b42-9d5f-6bd338eba0db@samsung.com>
Date: Mon, 5 Jan 2026 12:12:37 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] rust: pwm: Simplify to_result call sites and
 unsafe blocks
To: Kari Argillander <kari.argillander@gmail.com>,
	=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Miguel Ojeda
	<ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
	<gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
	Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
	Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20260102-pwm-rust-v2-2-2702ce57d571@gmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260105111237eucas1p13c973db6e3ce59f5d118bb43278ee11b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260102075215eucas1p2919c420a042781059f32d0747cd86baf
X-EPHeader: CA
X-CMS-RootMailID: 20260102075215eucas1p2919c420a042781059f32d0747cd86baf
References: <20260102-pwm-rust-v2-0-2702ce57d571@gmail.com>
	<CGME20260102075215eucas1p2919c420a042781059f32d0747cd86baf@eucas1p2.samsung.com>
	<20260102-pwm-rust-v2-2-2702ce57d571@gmail.com>



On 1/2/26 08:51, Kari Argillander wrote:
> Remove unnecessary temporary variables around to_result() calls and move
> trailing semicolons outside unsafe blocks to improve readability and
> produce cleaner rustfmt output.
> 
> No functional change intended.
> 
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> ---
>  rust/kernel/pwm.rs | 47 ++++++++++++++---------------------------------
>  1 file changed, 14 insertions(+), 33 deletions(-)
> 

Hi, the changes look fine to me, they are more idiomatic to Rust.

Acked-by: Michal Wilczynski <m.wilczynski@samsung.com>


