Return-Path: <linux-pwm+bounces-6751-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5DFAFAF5A
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jul 2025 11:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40DB817F818
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jul 2025 09:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F0928C2C9;
	Mon,  7 Jul 2025 09:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDMBMGRh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB0A19DFAB;
	Mon,  7 Jul 2025 09:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751879712; cv=none; b=B2rxQFsgFblr2ArkQ6WMTmbKDbCUfas1KOwqY1s9s2jRg09jEvZH20DX2jv/pG8bf3sagDtVpxHej9QMT91PMTwoaMq4ZbPKMEfZCPZhgJMTgWV/yjc885qteHoE0wWV1Ca8rfnf/4bry86HahW2lDAVg06SM5GMc1RckhMUfpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751879712; c=relaxed/simple;
	bh=s5LNAqpqCTtOzeV5j3oi7jngQje+htJG71VU5WzpWQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ty76zZhZHtZlsMmXbYB64nkHP50pBfbZ0gtwuCnkBAr103XM+3JindWyuYiow/PmTKOT2tCnBWVv6CTV+nRWKsCmp4Sqy6p/1dFqjngS+4+X+jjygkN6epWkYH22MS4wXyd2lgDyeKulWG8X/KNoSGWti34vW46Nl+HHNlWEr9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDMBMGRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEE6C4CEEF;
	Mon,  7 Jul 2025 09:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751879712;
	bh=s5LNAqpqCTtOzeV5j3oi7jngQje+htJG71VU5WzpWQE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WDMBMGRhjhaSH4iS9+2wyp0jAQP7F9gwtbtFBmJkfmYes/iElDwBHe0qFwfq+HhEL
	 OaxleHZlFo93WjGT4aXDJv37B10j6diALCLaAE0ETwZessChqz/lT6yvLhDT2sEDnV
	 YwWA106nDbY3SW5gMPA8fmr6sWYOmU3HOOpur1+Lj0mY3Fmqgb/ebcPkkBZM9WMehg
	 /MWJnFyh2ek03Vw2uprTeRq0Gdbfgr6wjF1fd3K++bN+pL4hKo0fKjfEFT91TaALpF
	 M9Qylp4CdNrkZ/P4cpBMAjH1dqD7I95jQddwzWKaLFnYVFrZFeejyTLLxP6vQUpuSH
	 QSzAS7uzHNBVQ==
Message-ID: <1b0aba4d-5e4f-4f5e-9a3a-978d6fde2847@kernel.org>
Date: Mon, 7 Jul 2025 11:15:05 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/6] rust: pwm: Add complete abstraction layer
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Benno Lossin <lossin@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Drew Fustini <fustini@kernel.org>, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
References: <20250706-rust-next-pwm-working-fan-for-sending-v9-0-42b5ac2101c7@samsung.com>
 <CGME20250706114605eucas1p17d1cbd035d14d95f4ad0588c2572b3e2@eucas1p1.samsung.com>
 <20250706-rust-next-pwm-working-fan-for-sending-v9-2-42b5ac2101c7@samsung.com>
 <aGpqqGMTU3a3O8cn@pollux> <002c8275-f17d-4a4e-b6b8-4dc74c4d510d@samsung.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <002c8275-f17d-4a4e-b6b8-4dc74c4d510d@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/7/25 9:30 AM, Michal Wilczynski wrote:
> On 7/6/25 14:23, Danilo Krummrich wrote:
>> If you overwrite this callback (as you do below) you're leaking the memory
>> allocated by pwmchip_alloc().
>>
>> The simple way to solve this would be to call pwmchip_release() from here.
> 
> Thanks, a pwmchip_release() is static though, so it's either expose the
> pwmchip_release in the header, or call kfree() here directly on pwmchip.

I'd export pwmchip_release() then, if you instead replicate what it does a
future change is pretty likely to be missed in the Rust abstraction.

