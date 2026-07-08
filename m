Return-Path: <linux-pwm+bounces-9643-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZIZyK79jTmohLwIAu9opvQ
	(envelope-from <linux-pwm+bounces-9643-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Jul 2026 16:50:39 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5E1727972
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Jul 2026 16:50:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=zohomail header.b=f6SQ6ozR;
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9643-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9643-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3095C30421F5
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jul 2026 14:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F9834D3B9;
	Wed,  8 Jul 2026 14:38:50 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1513161A2;
	Wed,  8 Jul 2026 14:38:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521530; cv=pass; b=ijvpg8NUc7DosmEqjIAwXD+cBvvyWCB+lszo8MwdLFfDlOoAi8fEEJ3e2xEBnjuQOZSMxqjf+UPkHQDSjElBbN3d/fM1Pb7qvIFTF8P6zA6lsIQEEeEsSUUuN3nh0026sBtVKOCvOAyexvnypxpWu8vxWF3H/nw9dnDlnpqLTD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521530; c=relaxed/simple;
	bh=LS3Er9/rUJO4Uq0PFkYQ5J0m8lSbFGIMaWRGsJ5V5j8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=hxWZijObDEuJ2ikRnmYV4nprO20D5AAPQTCG6gwvH0o1t03OCPVt3GCEScibE7dslaBlZ2T77+HdvTZ6uU3pSj3cx8atKwcyLyDQ8Xzk5fc/RHWKc61kTVCfFrP5zrSg+Pm4PUGvMmpCTdDvcFynm9geWJOojx5pli81sNG8vZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=f6SQ6ozR; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal: i=1; a=rsa-sha256; t=1783521497; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YI9KLNSqgyAoa9aM0cAmQldkCgz+KrFLJRASnXJQROPxfYRP23SbxOpE6MeJyV+l1vz1VD1nktiIXdBZwvteyJzUOaZx9DWqBF1atBX+7tCIHNVYV3hYMhO6M646K+iEzEOpb6Sti3pRlJOEJIB903Q3Z60OeJhP5nP1n8uWuKA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783521497; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Dz9e3DzXA9jmsTd/AXX4tRzwMh81Cxl6isVCCv3t7Pw=; 
	b=hVaBJbC3/bVUjDT9Aa+qm37WLClM65VhFxRHZweepi/UqlFOM+xKDDarhVOJ4n0TMjzXm99cVLLk438zcVQ/igSi1dbQPdPOprXEckXY/+awKIeWl0zATfThI2Kt7fbMRT8veL8vD0ZQt/6mjwVFVap7+IY4hkMpjx5UEKXESL8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783521497;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=Dz9e3DzXA9jmsTd/AXX4tRzwMh81Cxl6isVCCv3t7Pw=;
	b=f6SQ6ozR7FZO4RAo5W+scxh4D3hMm20YJG1+8gvebA7kW5e2C4DHiOh6dQO8UGzm
	tGf+4H4A27OfSG/b/6uoEYwYIACXfch3KwR5rJmXufWILrNXF1o6gM58U/dONIPBg+v
	kTc3hjEw33xHfh9ZM3MZkm7/CrRl3/MclcWmeFOI=
Received: by mx.zohomail.com with SMTPS id 1783521495227502.89899039827594;
	Wed, 8 Jul 2026 07:38:15 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 10/20] pwm: th1520: remove unnecessary `deref`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260706-io_projection-v6-10-72cd5d055d54@garyguo.net>
Date: Wed, 8 Jul 2026 11:37:55 -0300
Cc: Alice Ryhl <aliceryhl@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Tamir Duberstein <tamird@kernel.org>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Alexandre Courbot <acourbot@nvidia.com>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Michal Wilczynski <m.wilczynski@samsung.com>,
 =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 driver-core@lists.linux.dev,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org,
 nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org,
 linux-pwm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F4BA6E3F-3011-4DF6-930B-367C795966A8@collabora.com>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-10-72cd5d055d54@garyguo.net>
To: Gary Guo <gary@garyguo.net>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9643-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[daniel.almeida@collabora.com,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:acourbot@nvidia.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:gary@garyguo.net,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,linuxfoundation.org,kernel.org,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,nvidia.com,ffwll.ch,samsung.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.almeida@collabora.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	APPLE_MAILER_COMMON(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,garyguo.net:email,collabora.com:from_mime,collabora.com:email,collabora.com:mid,collabora.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E5E1727972



> On 6 Jul 2026, at 09:44, Gary Guo <gary@garyguo.net> wrote:
>=20
> `Deref` is automatic and should normally not be used directly.
> Also, `IoMem` is going to be implementing `Io` directly, so it will no
> longer to be implementing `Deref`.
>=20
> Reported-by: Andreas Hindborg <a.hindborg@kernel.org>
> Link: =
https://rust-for-linux.zulipchat.com/#narrow/channel/291565-Help/topic/.E2=
.9C.94.20Projection.20in.20dma.20bus.20address.20space/near/606672061
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
> drivers/pwm/pwm_th1520.rs | 7 ++-----
> 1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
> index 3e3fa51ccef9..022338d17218 100644
> --- a/drivers/pwm/pwm_th1520.rs
> +++ b/drivers/pwm/pwm_th1520.rs
> @@ -20,7 +20,6 @@
> //!   this method is not used in this driver.
> //!
>=20
> -use core::ops::Deref;
> use kernel::{
>     clk::Clk,
>     device::{Bound, Core, Device},
> @@ -213,8 +212,7 @@ fn read_waveform(
>     ) -> Result<Self::WfHw> {
>         let data =3D chip.drvdata();
>         let hwpwm =3D pwm.hwpwm();
> -        let iomem_accessor =3D data.iomem.access(parent_dev)?;
> -        let iomap =3D iomem_accessor.deref();
> +        let iomap =3D data.iomem.access(parent_dev)?;
>=20
>         let ctrl =3D iomap.try_read32(th1520_pwm_ctrl(hwpwm))?;
>         let period_cycles =3D =
iomap.try_read32(th1520_pwm_per(hwpwm))?;
> @@ -248,8 +246,7 @@ fn write_waveform(
>     ) -> Result {
>         let data =3D chip.drvdata();
>         let hwpwm =3D pwm.hwpwm();
> -        let iomem_accessor =3D data.iomem.access(parent_dev)?;
> -        let iomap =3D iomem_accessor.deref();
> +        let iomap =3D data.iomem.access(parent_dev)?;
>         let duty_cycles =3D iomap.try_read32(th1520_pwm_fp(hwpwm))?;
>         let was_enabled =3D duty_cycles !=3D 0;
>=20
>=20
> --=20
> 2.54.0
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


