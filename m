Return-Path: <linux-pwm+bounces-9178-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFN+BZP1FmrUywcAu9opvQ
	(envelope-from <linux-pwm+bounces-9178-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 15:45:55 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA62C5E548A
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 15:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06694300D474
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 13:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AE4421890;
	Wed, 27 May 2026 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="HFdEeSA0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C55F3DD531;
	Wed, 27 May 2026 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889207; cv=pass; b=aHxydmTX6GhLK5mjUAgFJNkojU9tSK0PMlNALnyiviU6H4ZW//NviESS6Yi8bEGHdBmofNvGR/WrySSVcTybTt48A8PkcUB6qnNlYO6VdonV5zlnFNi1xBL48Bw4sIQe3h0KECDsOj6HgompcXkKe1u1jd3PalsWT5DXwoDVpJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889207; c=relaxed/simple;
	bh=y/yenOk6WMktkywSzBANqFEfCqHm73KYiJZPpCiAfO4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=M/Nhqls1VqwZbnScvOp0t8R1LmIzsTM/HkSZ5lx/evPovdUDI4nleTofBjynbmokFpGl2fai5NDAI5lAlfR/taDXTYZg6IWj5uYIAYB+uD0W1Vw4Rp5k0Ldjx3yTa1kNRsjGagMSXgkcu0RcXv91O0Iz273NePogvYwwAzB7KNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=HFdEeSA0; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1779889143; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=A53WMoFTh4qmZlfGBesvsGfcd2hRyqtNdQw9iuZvSmNUsREmc3dfN/Et1zOFrsq84htdkIE2FkcAP3EJq8FlyZpm0+xBiYawrQw4Prjbox30VXJZSJzdDdLJFzZArEI9R6lBKR0chE+c0tUxfdB1473vifhZwIdgyAApK4Qjg+0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779889143; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nEEugzNfKPOCaWmJFszVxAfTXaai2yTXj9vTxlKTC+E=; 
	b=CllLONVCDfzfJFTLA+qb907oxXgHBK/lrgm65ASQBK4wcqlaXdC6VFkgp1lewDIVmW4TT84OVxPioacpfndUFL8wtfAWsBaC6Ff+WZq8tFAOconePX4rBGx/z9EdA5Tx48WyekLxe3YYqWm2WRgumwvbChmxgHqhS0xMbaoxswI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779889143;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=nEEugzNfKPOCaWmJFszVxAfTXaai2yTXj9vTxlKTC+E=;
	b=HFdEeSA0m5hN+GZZgqpHkjkLvH/3FiSsWxxzwyAW1D1B0ziAKBF/umHeDF6YdFFr
	BoKHKmeLyjzLjjXw6jG2btwQiL1dMlHX79IgGUflstjeMHgRhXLIBr3xhmJx1OKvUV5
	NDM9manI0g8sq+p2QW3QCyvphTYYSQUZlTqLDJkI=
Received: by mx.zohomail.com with SMTPS id 1779889140488922.6898610590684;
	Wed, 27 May 2026 06:39:00 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v5 15/24] rust: usb: make Driver trait
 lifetime-parameterized
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260525202921.124698-16-dakr@kernel.org>
Date: Wed, 27 May 2026 10:38:38 -0300
Cc: gregkh@linuxfoundation.org,
 rafael@kernel.org,
 acourbot@nvidia.com,
 aliceryhl@google.com,
 david.m.ertman@intel.com,
 ira.weiny@intel.com,
 leon@kernel.org,
 viresh.kumar@linaro.org,
 m.wilczynski@samsung.com,
 ukleinek@kernel.org,
 bhelgaas@google.com,
 kwilczynski@kernel.org,
 abdiel.janulgue@gmail.com,
 robin.murphy@arm.com,
 markus.probst@posteo.de,
 ojeda@kernel.org,
 boqun@kernel.org,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 lossin@kernel.org,
 a.hindborg@kernel.org,
 tmgross@umich.edu,
 igor.korotin@linux.dev,
 pcolberg@redhat.com,
 driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org,
 linux-pm@vger.kernel.org,
 linux-pwm@vger.kernel.org,
 linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 Eliot Courtney <ecourtney@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DC5BAEBC-3FF1-44E3-BD89-8770761D7548@collabora.com>
References: <20260525202921.124698-1-dakr@kernel.org>
 <20260525202921.124698-16-dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9178-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.almeida@collabora.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	APPLE_MAILER_COMMON(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,collabora.com:email,collabora.com:mid,collabora.com:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: AA62C5E548A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> On 25 May 2026, at 17:21, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> Add a 'bound lifetime to the associated Data, changing type Data to =
type
> Data<'bound>.
>=20
> This allows the driver's bus device private data to capture the device =
/
> driver bound lifetime; device resources can be stored directly by
> reference rather than requiring Devres.
>=20
> The probe() and disconnect() callbacks thus gain a 'bound lifetime
> parameter on the methods themselves; avoiding a global lifetime on the
> trait impl.
>=20
> Existing drivers set type Data<'bound> =3D Self, preserving the =
current
> behavior.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
> rust/kernel/usb.rs              | 37 ++++++++++++++++++++-------------
> samples/rust/rust_driver_usb.rs | 12 +++++------
> 2 files changed, 28 insertions(+), 21 deletions(-)
>=20
> diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
> index 1dbb8387b463..7aff0c82d0af 100644
> --- a/rust/kernel/usb.rs
> +++ b/rust/kernel/usb.rs
> @@ -41,7 +41,7 @@
> // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded =
`struct device_driver`.
> unsafe impl<T: Driver> driver::DriverLayout for Adapter<T> {
>     type DriverType =3D bindings::usb_driver;
> -    type DriverData<'bound> =3D T::Data;
> +    type DriverData<'bound> =3D T::Data<'bound>;
>     const DEVICE_DRIVER_OFFSET: usize =3D =
core::mem::offset_of!(Self::DriverType, driver);
> }
>=20
> @@ -109,8 +109,8 @@ extern "C" fn disconnect_callback(intf: *mut =
bindings::usb_interface) {
>=20
>         // SAFETY: `disconnect_callback` is only ever called after a =
successful call to
>         // `probe_callback`, hence it's guaranteed that =
`Device::set_drvdata()` has been called
> -        // and stored a `Pin<KBox<T::Data>>`.
> -        let data =3D unsafe { dev.drvdata_borrow::<T::Data>() };
> +        // and stored a `Pin<KBox<T::Data<'_>>>`.
> +        let data =3D unsafe { dev.drvdata_borrow::<T::Data<'_>>() };
>=20
>         T::disconnect(intf, data);
>     }
> @@ -287,18 +287,22 @@ macro_rules! usb_device_table {
> ///
> /// impl usb::Driver for MyDriver {
> ///     type IdInfo =3D ();
> -///     type Data =3D Self;
> +///     type Data<'bound> =3D Self;
> ///     const ID_TABLE: usb::IdTable<Self::IdInfo> =3D &USB_TABLE;
> ///
> -///     fn probe(
> -///         _interface: &usb::Interface<Core<'_>>,
> +///     fn probe<'bound>(
> +///         _interface: &'bound usb::Interface<Core<'_>>,
> ///         _id: &usb::DeviceId,
> -///         _info: &Self::IdInfo,
> -///     ) -> impl PinInit<Self::Data, Error> {
> +///         _info: &'bound Self::IdInfo,
> +///     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
> ///         Err(ENODEV)
> ///     }
> ///
> -///     fn disconnect(_interface: &usb::Interface<Core<'_>>, _data: =
Pin<&Self::Data>) {}
> +///     fn disconnect<'bound>(
> +///         _interface: &'bound usb::Interface<Core<'_>>,
> +///         _data: Pin<&Self::Data<'bound>>,
> +///     ) {
> +///     }
> /// }
> ///```
> pub trait Driver {
> @@ -306,7 +310,7 @@ pub trait Driver {
>     type IdInfo: 'static;
>=20
>     /// The type of the driver's bus device private data.
> -    type Data: Send;
> +    type Data<'bound>: Send + 'bound;
>=20
>     /// The table of device ids supported by the driver.
>     const ID_TABLE: IdTable<Self::IdInfo>;
> @@ -315,16 +319,19 @@ pub trait Driver {
>     ///
>     /// Called when a new USB interface is bound to this driver.
>     /// Implementers should attempt to initialize the interface here.
> -    fn probe(
> -        interface: &Interface<device::Core<'_>>,
> +    fn probe<'bound>(
> +        interface: &'bound Interface<device::Core<'_>>,
>         id: &DeviceId,
> -        id_info: &Self::IdInfo,
> -    ) -> impl PinInit<Self::Data, Error>;
> +        id_info: &'bound Self::IdInfo,
> +    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
>=20
>     /// USB driver disconnect.
>     ///
>     /// Called when the USB interface is about to be unbound from this =
driver.
> -    fn disconnect(interface: &Interface<device::Core<'_>>, data: =
Pin<&Self::Data>);
> +    fn disconnect<'bound>(
> +        interface: &'bound Interface<device::Core<'_>>,
> +        data: Pin<&Self::Data<'bound>>,
> +    );
> }
>=20
> /// A USB interface.
> diff --git a/samples/rust/rust_driver_usb.rs =
b/samples/rust/rust_driver_usb.rs
> index e900993335e9..02bd5085f9bc 100644
> --- a/samples/rust/rust_driver_usb.rs
> +++ b/samples/rust/rust_driver_usb.rs
> @@ -26,21 +26,21 @@ struct SampleDriver {
>=20
> impl usb::Driver for SampleDriver {
>     type IdInfo =3D ();
> -    type Data =3D Self;
> +    type Data<'bound> =3D Self;
>     const ID_TABLE: usb::IdTable<Self::IdInfo> =3D &USB_TABLE;
>=20
> -    fn probe(
> -        intf: &usb::Interface<Core<'_>>,
> +    fn probe<'bound>(
> +        intf: &'bound usb::Interface<Core<'_>>,
>         _id: &usb::DeviceId,
> -        _info: &Self::IdInfo,
> -    ) -> impl PinInit<Self, Error> {
> +        _info: &'bound Self::IdInfo,
> +    ) -> impl PinInit<Self, Error> + 'bound {
>         let dev: &device::Device<Core<'_>> =3D intf.as_ref();
>         dev_info!(dev, "Rust USB driver sample probed\n");
>=20
>         Ok(Self { _intf: intf.into() })
>     }
>=20
> -    fn disconnect(intf: &usb::Interface<Core<'_>>, _data: Pin<&Self>) =
{
> +    fn disconnect<'bound>(intf: &'bound usb::Interface<Core<'_>>, =
_data: Pin<&Self>) {
>         let dev: &device::Device<Core<'_>> =3D intf.as_ref();
>         dev_info!(dev, "Rust USB driver sample disconnected\n");
>     }
> --=20
> 2.54.0
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


