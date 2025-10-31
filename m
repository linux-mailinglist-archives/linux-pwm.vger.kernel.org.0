Return-Path: <linux-pwm+bounces-7575-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F26C25354
	for <lists+linux-pwm@lfdr.de>; Fri, 31 Oct 2025 14:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D98460DBB
	for <lists+linux-pwm@lfdr.de>; Fri, 31 Oct 2025 13:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA4F34A79B;
	Fri, 31 Oct 2025 13:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9+EqC5W"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1421B0413;
	Fri, 31 Oct 2025 13:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916357; cv=none; b=sJj2VIFf42hYOXUq+pTfJ8pRrh8xnu3MVu/5jY+kMpskITqto/II4bZWwUoRhE+UDqCbj9zUNMLuG5gogv2GIGLnd/gUHxA7Usu9nZYl0RfTSoUf5M1LX8x1IWj72RQnDtAEMadL0+ofTnaROeM1yqEXOHi4cB+z4msVwMB9Ydc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916357; c=relaxed/simple;
	bh=1rwfYJBuNs8Xw9hEJc66YBPhOXArAPLszXsQFe7O3u8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M1mP5V8s5kSSqJNBRNFoz5smeQ8Xm3jC6fjOSdgVqa8kCak4SG9oyDtu7pi5c4T/lbXthkWe6JJLBQD+Y8ZpXJVMRh+sJNLm5I66pGEnT6QnYICrNWSgfWBBfHRqOav/+lB9KEXzdxz3eIOlPareXkZjzXW9ejVadxs1BfGY8u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9+EqC5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D93C4CEE7;
	Fri, 31 Oct 2025 13:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761916356;
	bh=1rwfYJBuNs8Xw9hEJc66YBPhOXArAPLszXsQFe7O3u8=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f9+EqC5WRd/sDGGwiZxzmEIndtVF8XVgbt/QJAmmE32q/tHDSPgrSri5+smmC9Pa7
	 Vw5PQPOByMkPiV2tZCIQ4UBk8NcQv3mOjXCCNxHJnG9StvNFkbeRDlIjmJ3wY+o1wt
	 XkbPK1hO+Db8xlGyDbC4CtrTRG4bYvHkrPM8fSd3Wo8JJcdUXaYVj8X8wcEMu4jKH1
	 mqtVuFEZ2JuWZ2ShshkYF6VgstGKmGNAu7nMCB3O8+mZ7WngZPXJjxj/IBKGCoQz5L
	 23pZbJayCZ1hz21HLTlKLefWh5GO1JM0sDRQdm2BA7ppe5jbwGV11II5hJ5E0WY/6+
	 FuWkEGy2sOM1g==
Message-ID: <4654398f-324c-4465-88eb-8cadde6160dc@kernel.org>
Date: Fri, 31 Oct 2025 14:12:29 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH 1/4] rust: macros: Add support for 'imports_ns' to module!
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Michal Wilczynski <m.wilczynski@samsung.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Drew Fustini <fustini@kernel.org>,
 Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-modules@vger.kernel.org
References: <20251028-pwm_fixes-v1-0-25a532d31998@samsung.com>
 <CGME20251028122316eucas1p2733987cd4c1eb8f83d6572d542e76d2a@eucas1p2.samsung.com>
 <20251028-pwm_fixes-v1-1-25a532d31998@samsung.com>
 <h3sivr3uuzr5oodqe326svchbw3rzo4f4nw4chpeee2jwzjq3j@bdtecauehkn4>
 <CANiq72nNxVJeMZdESrrB+LGmdRK+M5AGZbUw-x2aE-Qa-=HtJQ@mail.gmail.com>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <CANiq72nNxVJeMZdESrrB+LGmdRK+M5AGZbUw-x2aE-Qa-=HtJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 31/10/2025 13.57, Miguel Ojeda wrote:
> On Fri, Oct 31, 2025 at 8:47 AM Uwe Kleine-König <ukleinek@kernel.org> wrote:
>>
>> I already asked this in reply to the cover letter, but the question was
>> lost on the way (no offense!), so I'm asking again. As it only really
>> affects this patch, I'm doing that here:
>>
>> Can I have some blessing to take this patch via my pwm tree? Would you
>> prefer a tag to also merge it into your tree? Then I would apply it on
>> top of 6.18-rc1 and provide a tag for you to merge.
> 
> Sounds fine to me, but I am Cc'ing the modules maintainers since they
> were not, just in case:
> 
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> 
> I think we don't need the tag/merge, unless someone else is looking to
> use this (is there such a user? I may have missed it).
> 
> Thanks!
> 
> Cheers,
> Miguel

Uwe, that's okay from modules side:

Acked-by: Daniel Gomez <da.gomez@samsung.com>

FYI, I haven't merged Andreas's patches (rust: extend `module!` macro with
integer parameter support) yet, which add rust/macros/module.rs to our
MAINTAINERS file list. So, it's fine from modules side to go through your tree.
I was aiming to merge these patches along with some others for this week but
I've found a regression in kmod testing introduced in the latest v6.18-rc1,
which is taking me some extra time.

