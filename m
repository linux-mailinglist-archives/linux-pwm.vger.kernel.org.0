Return-Path: <linux-pwm+bounces-6822-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 638C7B00D49
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 22:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C41D73B7C84
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 20:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC062FE30B;
	Thu, 10 Jul 2025 20:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhnowvdL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCE82FD877;
	Thu, 10 Jul 2025 20:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179990; cv=none; b=G9y+vapamA+/4koI/cKywRIk4RgHv51h9g789EdczcrclXa7xhRfrr6+Ji0hTdfLfi9iQo1HeGyx3NjvASX6rzeYJDDC4j7ERVyp/tnyW6kxRzAPSDxYIkoUH20pL0CAKyPZbqhIuBAK+RFc6RwZHv8fdFmhgNh5mWoEsEf0FlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179990; c=relaxed/simple;
	bh=vUrm0DBYVmQsNEyQ5kp5t9UXVn/4E5ekId4XN8uE1E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkY2Rie4nrUdBmj7OMPPrISnC0heouIDnOiP3br7eMvHFCz82Lhq45qCwBitxU1hFFa3E4D3C7Z5jwZiBe02zRbq34z7hy1fTYN5HmydZV/sL7mSkhHYJbWrpWaAxOOelCF5sB1C60pz7RyfYSbK42UW0Fcg/eJIQp8fL/qowWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhnowvdL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2451DC4CEE3;
	Thu, 10 Jul 2025 20:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752179989;
	bh=vUrm0DBYVmQsNEyQ5kp5t9UXVn/4E5ekId4XN8uE1E4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QhnowvdLwGxO5FcGiyEC/iTheG2sll0XVDRFDuo9968chhMNDZ2xDbMkK4lxAGRjE
	 +FPhnb8SmOCleRMMKyWU9qS9Uwfz8nonGFsHNjrGIQCgH8Lq6zSbflBBCbdvno7CfL
	 RH6/wB5hpeSJTFs3VRzwVo2/vLXpyHOGBauoRhhXcpLM1iWniCoJRuCH/uoy+GXQ6M
	 4LfYHRF2zmPbSw8vLcMRfyntkrB3SVWSnafdSW608uHstNLzmIS/QunPLsos0oXg0g
	 UBGfqZeMy/m1OCPJEDD0MsXyPwYup3i/fwUaauNKLYUSxu7GC4XQEQTqtNtzt8eZkz
	 jcC90wEB2wqyA==
Date: Thu, 10 Jul 2025 22:39:46 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Benno Lossin <lossin@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Drew Fustini <fustini@kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v10 0/7] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
Message-ID: <i5ee2u45kmcb2su743th744ofnmk4lkfq44iqvfwdjwscv3bz7@pjakppae22na>
References: <CGME20250707094926eucas1p155bd967b6986c4a999776839b1aa1fc6@eucas1p1.samsung.com>
 <20250707-rust-next-pwm-working-fan-for-sending-v10-0-d0c5cf342004@samsung.com>
 <e8a4a821-e7e4-4bcd-a2ac-f6b684b6ceea@samsung.com>
 <ipvaegqlkco5qinhvn33mqvg7ev2walvs74xtzvhimxsfsfzhv@gcmpxcdtetdn>
 <e77eab1c-446f-4620-95be-d343684d1e95@samsung.com>
 <4hmb3di5x2iei43nmrykrj5wzlltrf3vrnqvexiablonbscn57@4bbsz5c76t63>
 <ad17dc8a-80b7-4344-a1be-6cf780567aaa@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jtthsjazjtpn3zg5"
Content-Disposition: inline
In-Reply-To: <ad17dc8a-80b7-4344-a1be-6cf780567aaa@samsung.com>


--jtthsjazjtpn3zg5
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 0/7] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
MIME-Version: 1.0

Hello,

On Thu, Jul 10, 2025 at 06:58:41PM +0200, Michal Wilczynski wrote:
> On 7/10/25 17:25, Uwe Kleine-K=F6nig wrote:
> > On Thu, Jul 10, 2025 at 03:48:08PM +0200, Michal Wilczynski wrote:
> >> On 7/10/25 15:10, Uwe Kleine-K=F6nig wrote:
> >>> On Thu, Jul 10, 2025 at 10:42:07AM +0200, Michal Wilczynski wrote:
> >>>> On 7/7/25 11:48, Michal Wilczynski wrote:
> >>>>> The series is structured as follows:
> >>>>>  - Expose static function pwmchip_release.
> >>>
> >>> Is this really necessary? I didn't try to understand the requirements
> >>> yet, but I wonder about that. If you get the pwmchip from
> >>> __pwmchip_add() the right thing to do to release it is to call
> >>> pwmchip_remove(). Feels like a layer violation.
> >>
> >> It's required to prevent a memory leak in a specific, critical failure
> >> scenario. The sequence of events is as follows:
> >>
> >>     pwm::Chip::new() succeeds, allocating both the C struct pwm_chip a=
nd
> >>     the Rust drvdata.
> >>
> >>     pwm::Registration::register() (which calls pwmchip_add()) fails for
> >>     some reason.
> >=20
> > If you called pwmchip_alloc() but not yet pwmchip_add(), the right
> > function to call for cleanup is pwmchip_put().
> >=20
> >>     The ARef<Chip> returned by new() is dropped, its reference count
> >>     goes to zero, and our custom release_callback is called.
> >>
> >> [...]
> >>>>> ---
> >>>>> base-commit: 47753b5a1696283930a78aae79b29371f96f5bca
> >>>
> >>> I have problems applying this series and don't have this base commit =
in
> >>> my repo.
> >>
> >> Sorry for the confusion. Base commit doesn't exist in the mainline
> >> kernel or linux-next, cause I've added some dependecies for compilatio=
n,
> >> like IoMem for the driver (uploaded full branch on github [1]). The
> >> bindings however doesn't depend on anything that's not in linux-next.
> >=20
> > The series didn't apply to my pwm/for-next branch.
> >=20
> > Note that the base-commit should always be a publically known commit.
> > See the chapter about "Base Tree Information" in git-format-patch(1).
>=20
> Hello Uwe,
>=20
> Okay, thank you for the clarification. I understand the requirement for
> a public base commit.
>=20
> My intention was to include the TH1520 driver primarily as a practical
> demonstration of the new abstractions. However the driver can't be
> merged as is, since it depends on the unmerged IoMem series and won't
> compile against a public commit.
>=20
> I will rebase the series on pwm/for-next and drop the driver and its
> associated device tree patches for now. I'll send a new version
> containing just the core PWM abstraction patches, which apply cleanly.
>=20
> I will resubmit the driver patches once their dependencies are available
> in a public tree.

If you base your tree on (say) v6.16-rc1, then add some Rust
dependencies up to 47753b5a1696283930a78aae79b29371f96f5bca and then add
your series, you just do:

	git format-patch --base v6.16-rc1 47753b5a1696283930a78aae79b29371f96f5bca=
=2E.

=2E This results in a base-commit line that I (and maybe also build bots)
can use and a bunch of further lines listing the commits between
v6.16-rc1 and 47753b5a1696283930a78aae79b29371f96f5bca that might be
findable on lore.k.o.

Best regards
Uwe

--jtthsjazjtpn3zg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhwJQ8ACgkQj4D7WH0S
/k5+KwgAhf54BP4kesXyQExjra+S+O0lY+TfKRFwYNc0TlA1mA4Rm+cVJOx2VqWa
frCc5VeKCFE6+c89m85REdWNNdsSopomRCf0mrCVF+X8VkDLyCPKl3Lj7Yx0ZfVn
RFZl4QKG9y3843FRVetY6MtTIU8DXamyeY/Pr2yFfM94BfoDgaagQGuuQzuChQ9h
ydq075UFuzYr0pGEIMmKkNhBqPOKfy2TeahxEHiBe8pxLUugu+LMbcVeqPlcCXU1
igrkXeJ/DfKhdGvhywQXWazl/93kK0TbRncw/zdvGgB8hbS0NXSQk/qQMDt0mvwa
fB2HOYIpHDD3dNuiyoC/+lgbRGfHgA==
=L5lu
-----END PGP SIGNATURE-----

--jtthsjazjtpn3zg5--

