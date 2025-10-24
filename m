Return-Path: <linux-pwm+bounces-7486-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A118C07454
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Oct 2025 18:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F3B93583E40
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Oct 2025 16:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DED336EC8;
	Fri, 24 Oct 2025 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="k/jSHwlo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF61723C4FA
	for <linux-pwm@vger.kernel.org>; Fri, 24 Oct 2025 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322674; cv=none; b=E8NsoVMUBYvc1rq2z1v5z9XG4z0QdnHbMN6aj0aZWVerF08x74cF+CohsCwBNcEA8AosDb+QZVPedwIqgyJHZgreq1JyONzDL3lglKYiOjJPF07TaBIUM6joE1+jz4zj+vcnndbXDoiJpwRqmA+DU8lprSy7iEh/QkCprp0FMao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322674; c=relaxed/simple;
	bh=tOkgTJRdKnwh7l0mFsUVoENRh2qDXisSIfppjwcwMGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=R040vm3b87Ac2YTf9cXWcPB98LJr8owzYGYlU2gvC8IEKmhvTCzg2WXaRvkUFkAH2KeK0sraWRyyYMdocGX77gESstgCcN4vDkeAyXDACJdqQYJvTU0tiQWHdE9F1bvBpVKGfMNFKYSuWVbO/EyA6FeJ2Zt0Vfdu+BO49T3ku7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=k/jSHwlo; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251024161749euoutp02367a25ea4b586e32476239e60cb309f3~xeaK_NJ0Y3213732137euoutp02b
	for <linux-pwm@vger.kernel.org>; Fri, 24 Oct 2025 16:17:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251024161749euoutp02367a25ea4b586e32476239e60cb309f3~xeaK_NJ0Y3213732137euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1761322669;
	bh=4PztA7zevOPqcZ45Mj+9kAi61mRD2l7rMSjHCR1zJjo=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=k/jSHwloFZU2MSW6MgfbmET5vpqUP7ha0eqP9bHTJN2HQ7qMS1yqo9m16uMb4jdEv
	 BIohBBFP6C/+ovZhd8v6YlUWY5+Ctx9MWcaOESEnFG4zhqb8VorGNly3KoG5Lz9kmF
	 /7hqPxwMdGvhX/+6mQObh4cUxQp4s/xW7zH4zfQo=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251024161747eucas1p232c73d8cbf4cda89571193714279df1e~xeaJ2q_gt2872228722eucas1p2a;
	Fri, 24 Oct 2025 16:17:47 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251024161746eusmtip181c8b0d66d145b6fc0382af657d5c8de~xeaItjh0p0255002550eusmtip1G;
	Fri, 24 Oct 2025 16:17:46 +0000 (GMT)
Message-ID: <9f38bb32-9160-4acd-83d7-902d3e1cad72@samsung.com>
Date: Fri, 24 Oct 2025 18:17:46 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 0/7] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas
	Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
	Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Guo Ren
	<guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
	Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
	Ghiti <alex@ghiti.fr>, Marek Szyprowski <m.szyprowski@samsung.com>, Benno
	Lossin <lossin@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
	Drew Fustini <fustini@kernel.org>, Daniel Almeida
	<daniel.almeida@collabora.com>, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, Elle Rhumsaa
	<elle@weathered-steel.dev>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <p5addblaeofj6xdbgmvrknoozrxh75lsle6uqh4g2qku745ayw@uls3uoftpmuw>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251024161747eucas1p232c73d8cbf4cda89571193714279df1e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251016133814eucas1p199cb62658c016e84e34d525e7c87f16e
X-EPHeader: CA
X-CMS-RootMailID: 20251016133814eucas1p199cb62658c016e84e34d525e7c87f16e
References: <CGME20251016133814eucas1p199cb62658c016e84e34d525e7c87f16e@eucas1p1.samsung.com>
	<20251016-rust-next-pwm-working-fan-for-sending-v16-0-a5df2405d2bd@samsung.com>
	<3f9ab01c-470e-48b5-a309-71325ecc4906@samsung.com>
	<p5addblaeofj6xdbgmvrknoozrxh75lsle6uqh4g2qku745ayw@uls3uoftpmuw>



On 10/24/25 16:09, Uwe Kleine-König wrote:
> Hello Michael,
> 
> On Wed, Oct 22, 2025 at 10:34:42AM +0200, Michal Wilczynski wrote:
>> Since you mentioned last time that you were happy with the code, would
>> you please consider picking up this series for linux-next? It would be
>> great to get it in for wider testing to ensure everything is solid.
> 
> I took another look, and just being able to compile and understanding
> very little Rust, I came up with:
> 
> diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
> index 79fbb13cd47f..c8f9f5b61bfa 100644
> --- a/rust/kernel/pwm.rs
> +++ b/rust/kernel/pwm.rs
> @@ -15,38 +15,7 @@
>      prelude::*,
>      types::{ARef, AlwaysRefCounted, Opaque},
>  };
> -use core::{convert::TryFrom, marker::PhantomData, ptr::NonNull};
> +use core::{marker::PhantomData, ptr::NonNull};
> -
> -/// PWM polarity. Mirrors [`enum pwm_polarity`](srctree/include/linux/pwm.h).
> -#[derive(Copy, Clone, Debug, PartialEq, Eq)]
> -pub enum Polarity {
> -    /// Normal polarity (duty cycle defines the high period of the signal).
> -    Normal,
> -
> -    /// Inversed polarity (duty cycle defines the low period of the signal).
> -    Inversed,
> -}
> -
> -impl TryFrom<bindings::pwm_polarity> for Polarity {
> -    type Error = Error;
> -
> -    fn try_from(polarity: bindings::pwm_polarity) -> Result<Self, Error> {
> -        match polarity {
> -            bindings::pwm_polarity_PWM_POLARITY_NORMAL => Ok(Polarity::Normal),
> -            bindings::pwm_polarity_PWM_POLARITY_INVERSED => Ok(Polarity::Inversed),
> -            _ => Err(EINVAL),
> -        }
> -    }
> -}
> -
> -impl From<Polarity> for bindings::pwm_polarity {
> -    fn from(polarity: Polarity) -> Self {
> -        match polarity {
> -            Polarity::Normal => bindings::pwm_polarity_PWM_POLARITY_NORMAL,
> -            Polarity::Inversed => bindings::pwm_polarity_PWM_POLARITY_INVERSED,
> -        }
> -    }
> -}
>  
>  /// Represents a PWM waveform configuration.
>  /// Mirrors struct [`struct pwm_waveform`](srctree/include/linux/pwm.h).
> @@ -89,22 +58,6 @@ fn from(wf: Waveform) -> Self {
>      }
>  }
>  
> -/// Wrapper for PWM state [`struct pwm_state`](srctree/include/linux/pwm.h).
> -#[repr(transparent)]
> -pub struct State(bindings::pwm_state);
> -
> -impl State {
> -    /// Creates a `State` wrapper by taking ownership of a C `pwm_state` value.
> -    pub(crate) fn from_c(c_state: bindings::pwm_state) -> Self {
> -        State(c_state)
> -    }
> -
> -    /// Returns `true` if the PWM signal is enabled.
> -    pub fn enabled(&self) -> bool {
> -        self.0.enabled
> -    }
> -}
> -
>  /// Describes the outcome of a `round_waveform` operation.
>  #[derive(Debug, Clone, Copy, PartialEq, Eq)]
>  pub enum RoundingOutcome {
> @@ -164,13 +117,6 @@ pub fn label(&self) -> Option<&CStr> {
>          Some(unsafe { CStr::from_char_ptr(label_ptr) })
>      }
>  
> -    /// Gets a copy of the current state of this PWM device.
> -    pub fn state(&self) -> State {
> -        // SAFETY: `self.as_raw()` gives a valid pointer. `(*self.as_raw()).state`
> -        // is a valid `pwm_state` struct. `State::from_c` copies this data.
> -        State::from_c(unsafe { (*self.as_raw()).state })
> -    }
> -
>      /// Sets the PWM waveform configuration and enables the PWM signal.
>      pub fn set_waveform(&self, wf: &Waveform, exact: bool) -> Result {
>          let c_wf = bindings::pwm_waveform::from(*wf);
> 
> Does that make sense?

Hi Uwe,

Yes, that makes perfect sense.

I agree with your patch. I initially thought the State wrapper might be
necessary for the TH1520 driver, but I was able to refactor it to work
without it.

On reflection, both Polarity and State are really remnants of the older,
legacy API. Removing them is a good cleanup; it ensures future Rust
drivers will use the modern waveform API and avoids potential confusion.

> 
> I consider applying your series and put the above space on top, to
> create my first Rust patch :-)

Great ! Congratulations on your first Rust patch :-)

On a related note there is this diff necessary to make CLIPPY happy:
diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index 0ad38b78be85..a6c3b6025152 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -185,7 +185,7 @@ fn round_waveform_tohw(
         );
 
         Ok(pwm::RoundedWaveform {
-            status: status,
+            status,
             hardware_waveform: wfhw,
         })
     }

I could re-send the patchset, but since you're making a patch anyway
maybe you would also like to pick this ?

> 
> Best regards
> Uwe

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

