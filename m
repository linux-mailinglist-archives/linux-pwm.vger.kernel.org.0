Return-Path: <linux-pwm+bounces-6971-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C14F2B1C660
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Aug 2025 14:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4879818C366E
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Aug 2025 12:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC714262FE5;
	Wed,  6 Aug 2025 12:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="NNL+i1UD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC86E18035;
	Wed,  6 Aug 2025 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754484613; cv=pass; b=Wr+ejYL/9fEI5mqDTy62oYPF1nfsGk5J2ZN0j2jae0SvFFuuKB+4PowspZPxVTn8LLouWV8gUSyV7Hg/8Qc7i8JonkWJ66IkA27uzzp4as4wEkgj/V5RBGwroFkv26s1kJLqqvKNtjijlpMPHAJfpPVy25QxCySE3MH+T3oFSMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754484613; c=relaxed/simple;
	bh=qsNPYd7JE3LVhYFm81593Z/HO+ZNsVr6ff5n10xfmqM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kHUqBgj7NVtZm6naATX3ibp6PrmeaHvgvlKOVVaFWXFAVqQyrk4gNz/INlD0vtzWe9dgbfUJh4TwtxzP8LmMH6Y8kzt2NQEkj+VB0s6cZ101gNtnUS72K1f82uGH3BEF1Hbi4jUUDW3mGKhOEPYRNfguGBerIopJ4c1y94dVF14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=NNL+i1UD; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1754484581; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TdIYSsrpWIPTG1jidR1iuSPofUBS7dA1PyO7N+53KeFo91HY/CU5M81cEjLj16G20LoN18ziCK0qtw6J1NHw2pVD75q/+GLYYuZzypgX+9TdwWw8lXNHt4nJqF06vQHPz0WXyLukwUtQQDKfOlCtfCU7rJGGgmMXGdPOvcJNHlI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754484581; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bJtLcKeKURRlW9n36AmDiYBFj9adzcRfgds4/JvblNc=; 
	b=U9H9GMvUxhBuK2Fauj81NTtTMjiLs9x7S+F3+4VNd1oEVb6kQys0eDwnvDdydOfq5MjdMvyIzqRuPgpbRRx4ALN2XrZzR3N+P4j0f5BB/tbPQ5u11QhAvo9I83maLxs3NkfEZmgElVvDMdKzG5FpP89LttIhYub1J1lrjvhevFs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754484581;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=bJtLcKeKURRlW9n36AmDiYBFj9adzcRfgds4/JvblNc=;
	b=NNL+i1UDcH2FhizRgwdMRIzcKnkcnBXUCwN39+K/lO4hsc994E/1kkmEwesytZN8
	DtWMIlr1wF20rszBl9U0PkJ/A1ZYewGvBJ0thoKP0WmDTKVI3QRzxC1JmQ5iedm3NSL
	GQj1AMDpR2e96zpfTyfo6e09f7gWBsinvEBk9Kv0=
Received: by mx.zohomail.com with SMTPS id 1754484579257241.02773267205032;
	Wed, 6 Aug 2025 05:49:39 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v12 3/3] rust: pwm: Add complete abstraction layer
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <8ad10cc3-6e7d-4a8b-b6f6-9568403ee2b3@samsung.com>
Date: Wed, 6 Aug 2025 09:49:21 -0300
Cc: =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Drew Fustini <drew@pdp7.com>,
 Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Benno Lossin <lossin@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Drew Fustini <fustini@kernel.org>,
 linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8C20C615-DBF2-4DF9-9AB3-E78C4B1E7493@collabora.com>
References: <20250717-rust-next-pwm-working-fan-for-sending-v12-0-40f73defae0c@samsung.com>
 <CGME20250717090833eucas1p16c916450b59a77d81bd013527755cb21@eucas1p1.samsung.com>
 <20250717-rust-next-pwm-working-fan-for-sending-v12-3-40f73defae0c@samsung.com>
 <42C9DF97-2E0F-453B-800A-1DA49BF8F29F@collabora.com>
 <8ad10cc3-6e7d-4a8b-b6f6-9568403ee2b3@samsung.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Michal,

> On 4 Aug 2025, at 19:29, Michal Wilczynski <m.wilczynski@samsung.com> =
wrote:
>=20
>=20
> On 7/25/25 17:56, Daniel Almeida wrote:
>>> +
>>> +    /// Gets the label for this PWM device, if any.
>>> +    pub fn label(&self) -> Option<&CStr> {
>>> +        // SAFETY: self.as_raw() provides a valid pointer.
>>> +        let label_ptr =3D unsafe { (*self.as_raw()).label };
>>> +        if label_ptr.is_null() {
>>> +            None
>>> +        } else {
>>> +            // SAFETY: label_ptr is non-null and points to a C =
string
>>> +            // managed by the kernel, valid for the lifetime of the =
PWM device.
>>> +            Some(unsafe { CStr::from_char_ptr(label_ptr) })
>>> +        }
>>> +    }
>>=20
>> nit: this can be written more concisely, but I personally don=E2=80=99t=
 mind.
>=20
> Do you have something specific in mind ? I think the alternative way =
of
> expressing this would use NonNull, but somehow this feels less =
readable
> for me.

Yes, an early return, i.e.:

if label_ptr.is_null() {
  return None
}

It saves you one level of indentation by removing the else branch.

>=20
>=20
>>> +
>>> +/// Trait defining the operations for a PWM driver.
>>> +pub trait PwmOps: 'static + Sized {
>>> +    /// The driver-specific hardware representation of a waveform.
>>> +    ///
>>> +    /// This type must be [`Copy`], [`Default`], and fit within =
`PWM_WFHWSIZE`.
>>> +    type WfHw: Copy + Default;
>>=20
>> Can=E2=80=99t you use a build_assert!() here? i.e.:
>>=20
>>    #[doc(hidden)]
>>    const _CHECK_SZ: () =3D {
>>        build_assert!(core::mem::size_of::<Self::WfHw>() <=3D =
bindings::PWM_WFHWSIZE as usize);
>>    };
>=20
> This doesn't work i.e the driver using oversized WfHw compiles
> correctly, but putting the assert inside the serialize did work, =
please
> see below.

Can you show how it looks like with the build_assert included? Just as a =
sanity check.

>=20
>=20
>>=20
>>> +        Err(ENOTSUPP)
>>> +    }
>>> +
>>> +    /// Convert a hardware-specific representation back to a =
generic waveform.
>>> +    /// This is typically a pure calculation and does not perform =
I/O.
>>> +    fn round_waveform_fromhw(
>>> +        _chip: &Chip<Self>,
>>> +        _pwm: &Device,
>>> +        _wfhw: &Self::WfHw,
>>> +        _wf: &mut Waveform,
>>> +    ) -> Result<c_int> {
>>> +        Err(ENOTSUPP)
>>> +    }
>>=20
>> Please include at least a description of what this returns.
>=20
> Instead I think it should just return Result, reviewed the code and =
it's
> fine.
>=20

Ack.

>>=20
>>> +/// Bridges Rust `PwmOps` to the C `pwm_ops` vtable.
>>> +struct Adapter<T: PwmOps> {
>>> +    _p: PhantomData<T>,
>>> +}
>>> +
>>> +impl<T: PwmOps> Adapter<T> {
>>> +    const VTABLE: PwmOpsVTable =3D create_pwm_ops::<T>();
>>> +
>>> +    /// # Safety
>>> +    ///
>>> +    /// `wfhw_ptr` must be valid for writes of =
`size_of::<T::WfHw>()` bytes.
>>> +    unsafe fn serialize_wfhw(wfhw: &T::WfHw, wfhw_ptr: *mut c_void) =
-> Result {
>>> +        let size =3D core::mem::size_of::<T::WfHw>();
>>> +        if size > bindings::PWM_WFHWSIZE as usize {
>>> +            return Err(EINVAL);
>>> +        }
>>=20
>> See my previous comment on using build_assert if possible.
>=20
> So I did try this and it does work, however it results in a cryptic
> linker error:
> ld.lld: error: undefined symbol: rust_build_error
>>>> referenced by pwm_th1520.2c2c3938312114c-cgu.0
>>>>              =
drivers/pwm/pwm_th1520.o:(<kernel::pwm::Adapter<pwm_th1520::Th1520PwmDrive=
rData>>::read_waveform_callback) in archive vmlinux.a
>>>> referenced by pwm_th1520.2c2c3938312114c-cgu.0
>>>>              =
drivers/pwm/pwm_th1520.o:(<kernel::pwm::Adapter<pwm_th1520::Th1520PwmDrive=
rData>>::round_waveform_tohw_callback) in archive vmlinux.a
> make[2]: *** [scripts/Makefile.vmlinux:91: vmlinux] Error 1
>=20
> I assume this could be fixed at some point to better explain what
> failed? I think putting the assert in serialize functions is fine and
> the proposed _CHECK_SZ isn't really required.
>=20
> I would love to do some debugging and find out why that is myself if
> time allows :-)

There is nothing wrong here. A canonical Rust-for-Linux experience is =
stumbling
upon the error generated by build_assert and being rightly confused. =
People ask
about this every few months :)

This just means that the build_assert triggered and the build failed as =
a
result. IOW, it means that your build_assert is working properly to =
catch
errors.

=E2=80=94 Daniel


