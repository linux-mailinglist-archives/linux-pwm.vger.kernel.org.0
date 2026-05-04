Return-Path: <linux-pwm+bounces-8768-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TGGNOIZz+Gk9vgIAu9opvQ
	(envelope-from <linux-pwm+bounces-8768-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 04 May 2026 12:23:02 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 580B04BBA4A
	for <lists+linux-pwm@lfdr.de>; Mon, 04 May 2026 12:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32E85304C94D
	for <lists+linux-pwm@lfdr.de>; Mon,  4 May 2026 10:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AD939B49E;
	Mon,  4 May 2026 10:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TrBIaTHB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B8439A06F;
	Mon,  4 May 2026 10:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889918; cv=none; b=lMD5je2HZAiy/EhS9zWq7aWTIUplUVdOMZGjPdFBDmzC9AOFy1zrBsEFbuMcWHATIB13Mx1p6rED6gqJyJzMA6Y3QYZ+glIu81dGIGswOJ5TEjp0gAgF01OBP9iO1CPaGwb9f/Tddk4Bjlrv74ioU2W4oaGbMWpTVLWFZY38nNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889918; c=relaxed/simple;
	bh=m3IwP9EUP4YpRl+pQkOJzg9P6GgXjAd9jWulhfALmHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=owKs4JmarFFzKfz5ycWEZToF2MBicow6vTiEbsF6STYA2EEXnxMTE0grfUy66mcHGpivweedGaafIy2KVtbM5r+JzFR6VX6zoWQCCzxJoAvhcZiTa2YwMBNIq6owhq9jAGto8mOr566sd58urWlGPy4ru646zFXRSUoVriXkaD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TrBIaTHB; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9f324d14-bee4-4943-b282-fe2029a3464d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777889902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rbka3AkAOUMoynajA/9NaQsmcGpTjVTQAeBCqupUVbg=;
	b=TrBIaTHBcc2VZNo5hUp2U8WXvMqEy/GzPsRmt+rfTgm7XCN0qan3er/jb0kL8gsyEkKaRh
	T+2f6QQrCTU4NYwOWcC6qbHe6aZNB2b9pAlwmP6jjjALvP3ag600iDXxz/JBPR5nyASOVH
	erYpCGtYy9CB9s4gkkjBc8E0elk+k2Q=
Date: Mon, 4 May 2026 11:18:17 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 17/24] rust: i2c: make Driver trait lifetime-parameterized
To: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org,
 rafael@kernel.org, acourbot@nvidia.com, aliceryhl@google.com,
 david.m.ertman@intel.com, ira.weiny@intel.com, leon@kernel.org,
 viresh.kumar@linaro.org, m.wilczynski@samsung.com, ukleinek@kernel.org,
 bhelgaas@google.com, kwilczynski@kernel.org, abdiel.janulgue@gmail.com,
 robin.murphy@arm.com, markus.probst@posteo.de, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20260427221155.2144848-1-dakr@kernel.org>
 <20260427221155.2144848-18-dakr@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Igor Korotin <igor.korotin@linux.dev>
In-Reply-To: <20260427221155.2144848-18-dakr@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 580B04BBA4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8768-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[igor.korotin@linux.dev,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]



On 4/27/2026 11:11 PM, Danilo Krummrich wrote:
> Make i2c::Driver take a lifetime parameter 'a that ties device resources
> to the binding scope.
> 
> Internally, Adapter<T: Driver> becomes Adapter<F: ForLt> with a bound
> for<'a> F::Of<'a>: Driver<'a>; module_i2c_driver! wraps the driver type
> in ForLt!() so drivers don't have to.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>   rust/kernel/i2c.rs              | 116 +++++++++++++++++++-------------
>   samples/rust/rust_driver_i2c.rs |  18 ++---
>   2 files changed, 78 insertions(+), 56 deletions(-)
> 
> diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
> index 08d310aa9d6b..4464146d6c4d 100644
> --- a/rust/kernel/i2c.rs
> +++ b/rust/kernel/i2c.rs
> @@ -92,43 +92,57 @@ macro_rules! i2c_device_table {
>   }
>   
>   /// An adapter for the registration of I2C drivers.
> -pub struct Adapter<T: Driver>(T);
> +///
> +/// `F` is a [`ForLt`](trait@ForLt) type that maps lifetimes to the driver's device
> +/// private data type, i.e. `F::Of<'a>` is the driver struct parameterized by `'a`. The macro
> +/// `module_i2c_driver!` generates this automatically via `ForLt!()`.
> +pub struct Adapter<F>(PhantomData<F>);
>   
>   // SAFETY:
>   // - `bindings::i2c_driver` is a C type declared as `repr(C)`.
> -// - `T` is the type of the driver's device private data.
> +// - `F::Of<'static>` is the stored type of the driver's device private data.
>   // - `struct i2c_driver` embeds a `struct device_driver`.
>   // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
> -unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
> +unsafe impl<F> driver::DriverLayout for Adapter<F>
> +where
> +    F: ForLt + 'static,
> +    for<'a> F::Of<'a>: Driver<'a>,
> +{
>       type DriverType = bindings::i2c_driver;
> -    type DriverData = ForLt!(T);
> +    type DriverData = F;
>       const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
>   }
>   
>   // SAFETY: A call to `unregister` for a given instance of `DriverType` is guaranteed to be valid if
>   // a preceding call to `register` has been successful.
> -unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
> +unsafe impl<F> driver::RegistrationOps for Adapter<F>
> +where
> +    F: ForLt + 'static,
> +    for<'a> F::Of<'a>: Driver<'a>,
> +{
>       unsafe fn register(
>           idrv: &Opaque<Self::DriverType>,
>           name: &'static CStr,
>           module: &'static ThisModule,
>       ) -> Result {
>           build_assert!(
> -            T::ACPI_ID_TABLE.is_some() || T::OF_ID_TABLE.is_some() || T::I2C_ID_TABLE.is_some(),
> +            <F::Of<'static> as Driver<'static>>::ACPI_ID_TABLE.is_some()
> +                || <F::Of<'static> as Driver<'static>>::OF_ID_TABLE.is_some()
> +                || <F::Of<'static> as Driver<'static>>::I2C_ID_TABLE.is_some(),
>               "At least one of ACPI/OF/Legacy tables must be present when registering an i2c driver"
>           );
>   
> -        let i2c_table = match T::I2C_ID_TABLE {
> +        let i2c_table = match <F::Of<'static> as Driver<'static>>::I2C_ID_TABLE {
>               Some(table) => table.as_ptr(),
>               None => core::ptr::null(),
>           };
>   
> -        let of_table = match T::OF_ID_TABLE {
> +        let of_table = match <F::Of<'static> as Driver<'static>>::OF_ID_TABLE {
>               Some(table) => table.as_ptr(),
>               None => core::ptr::null(),
>           };
>   
> -        let acpi_table = match T::ACPI_ID_TABLE {
> +        let acpi_table = match <F::Of<'static> as Driver<'static>>::ACPI_ID_TABLE {
>               Some(table) => table.as_ptr(),
>               None => core::ptr::null(),
>           };
> @@ -154,7 +168,11 @@ unsafe fn unregister(idrv: &Opaque<Self::DriverType>) {
>       }
>   }
>   
> -impl<T: Driver + 'static> Adapter<T> {
> +impl<F> Adapter<F>
> +where
> +    F: ForLt + 'static,
> +    for<'a> F::Of<'a>: Driver<'a>,
> +{
>       extern "C" fn probe_callback(idev: *mut bindings::i2c_client) -> kernel::ffi::c_int {
>           // SAFETY: The I2C bus only ever calls the probe callback with a valid pointer to a
>           // `struct i2c_client`.
> @@ -162,13 +180,12 @@ extern "C" fn probe_callback(idev: *mut bindings::i2c_client) -> kernel::ffi::c_
>           // INVARIANT: `idev` is valid for the duration of `probe_callback()`.
>           let idev = unsafe { &*idev.cast::<I2cClient<device::CoreInternal>>() };
>   
> -        let info = Self::i2c_id_info(idev)
> -            .or_else(|| <Self as driver::Adapter<'_>>::id_info(idev.as_ref()));
> -
>           from_result(|| {
> -            let data = T::probe(idev, info);
> +            let info = Self::i2c_id_info(idev)
> +                .or_else(|| <Self as driver::Adapter<'_>>::id_info(idev.as_ref()));
> +            let data = <F::Of<'_> as Driver<'_>>::probe(idev, info);
>   
> -            idev.as_ref().set_drvdata::<ForLt!(T)>(data)?;
> +            idev.as_ref().set_drvdata::<F>(data)?;
>               Ok(0)
>           })
>       }
> @@ -178,11 +195,10 @@ extern "C" fn remove_callback(idev: *mut bindings::i2c_client) {
>           let idev = unsafe { &*idev.cast::<I2cClient<device::CoreInternal>>() };
>   
>           // SAFETY: `remove_callback` is only ever called after a successful call to
> -        // `probe_callback`, hence it's guaranteed that `I2cClient::set_drvdata()` has been called
> -        // and stored a `Pin<KBox<T>>`.
> -        let data = unsafe { idev.as_ref().drvdata_borrow::<ForLt!(T)>() };
> +        // `probe_callback`, hence it's guaranteed that drvdata has been set.
> +        let data = unsafe { idev.as_ref().drvdata_borrow::<F>() };
>   
> -        T::unbind(idev, data);
> +        <F::Of<'_> as Driver<'_>>::unbind(idev, data);
>       }
>   
>       extern "C" fn shutdown_callback(idev: *mut bindings::i2c_client) {
> @@ -190,23 +206,22 @@ extern "C" fn shutdown_callback(idev: *mut bindings::i2c_client) {
>           let idev = unsafe { &*idev.cast::<I2cClient<device::CoreInternal>>() };
>   
>           // SAFETY: `shutdown_callback` is only ever called after a successful call to
> -        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
> -        // and stored a `Pin<KBox<T>>`.
> -        let data = unsafe { idev.as_ref().drvdata_borrow::<ForLt!(T)>() };
> +        // `probe_callback`, hence it's guaranteed that drvdata has been set.
> +        let data = unsafe { idev.as_ref().drvdata_borrow::<F>() };
>   
> -        T::shutdown(idev, data);
> +        <F::Of<'_> as Driver<'_>>::shutdown(idev, data);
>       }
>   
>       /// The [`i2c::IdTable`] of the corresponding driver.
> -    fn i2c_id_table() -> Option<IdTable<<Self as driver::Adapter<'static>>::IdInfo>> {
> -        T::I2C_ID_TABLE
> +    fn i2c_id_table<'a>() -> Option<IdTable<<F::Of<'a> as Driver<'a>>::IdInfo>> {
> +        <F::Of<'a> as Driver<'a>>::I2C_ID_TABLE
>       }
>   
>       /// Returns the driver's private data from the matching entry in the [`i2c::IdTable`], if any.
>       ///
>       /// If this returns `None`, it means there is no match with an entry in the [`i2c::IdTable`].
> -    fn i2c_id_info(dev: &I2cClient) -> Option<&'static <Self as driver::Adapter<'static>>::IdInfo> {
> -        let table = Self::i2c_id_table()?;
> +    fn i2c_id_info<'a>(dev: &I2cClient) -> Option<&'a <F::Of<'a> as Driver<'a>>::IdInfo> {
> +        let table = Self::i2c_id_table::<'a>()?;
>   
>           // SAFETY:
>           // - `table` has static lifetime, hence it's valid for reads
> @@ -225,15 +240,19 @@ fn i2c_id_info(dev: &I2cClient) -> Option<&'static <Self as driver::Adapter<'sta
>       }
>   }
>   
> -impl<'a, T: Driver + 'static> driver::Adapter<'a> for Adapter<T> {
> -    type IdInfo = T::IdInfo;
> +impl<'a, F> driver::Adapter<'a> for Adapter<F>
> +where
> +    F: ForLt + 'static,
> +    F::Of<'a>: Driver<'a>,
> +{
> +    type IdInfo = <F::Of<'a> as Driver<'a>>::IdInfo;
>   
>       fn of_id_table() -> Option<of::IdTable<Self::IdInfo>> {
> -        T::OF_ID_TABLE
> +        <F::Of<'a> as Driver<'a>>::OF_ID_TABLE
>       }
>   
>       fn acpi_id_table() -> Option<acpi::IdTable<Self::IdInfo>> {
> -        T::ACPI_ID_TABLE
> +        <F::Of<'a> as Driver<'a>>::ACPI_ID_TABLE
>       }
>   }
>   
> @@ -252,8 +271,11 @@ fn acpi_id_table() -> Option<acpi::IdTable<Self::IdInfo>> {
>   /// ```
>   #[macro_export]
>   macro_rules! module_i2c_driver {
> -    ($($f:tt)*) => {
> -        $crate::module_driver!(<T>, $crate::i2c::Adapter<T>, { $($f)* });
> +    (type: $type:ty, $($rest:tt)*) => {
> +        $crate::module_driver!(<T>, $crate::i2c::Adapter<T>, {
> +            type: $crate::types::ForLt!($type),
> +            $($rest)*
> +        });
>       };
>   }
>   
> @@ -271,7 +293,7 @@ macro_rules! module_i2c_driver {
>   /// kernel::acpi_device_table!(
>   ///     ACPI_TABLE,
>   ///     MODULE_ACPI_TABLE,
> -///     <MyDriver as i2c::Driver>::IdInfo,
> +///     <MyDriver as i2c::Driver<'_>>::IdInfo,
>   ///     [
>   ///         (acpi::DeviceId::new(c"LNUXBEEF"), ())
>   ///     ]
> @@ -280,7 +302,7 @@ macro_rules! module_i2c_driver {
>   /// kernel::i2c_device_table!(
>   ///     I2C_TABLE,
>   ///     MODULE_I2C_TABLE,
> -///     <MyDriver as i2c::Driver>::IdInfo,
> +///     <MyDriver as i2c::Driver<'_>>::IdInfo,
>   ///     [
>   ///          (i2c::DeviceId::new(c"rust_driver_i2c"), ())
>   ///     ]
> @@ -289,30 +311,30 @@ macro_rules! module_i2c_driver {
>   /// kernel::of_device_table!(
>   ///     OF_TABLE,
>   ///     MODULE_OF_TABLE,
> -///     <MyDriver as i2c::Driver>::IdInfo,
> +///     <MyDriver as i2c::Driver<'_>>::IdInfo,
>   ///     [
>   ///         (of::DeviceId::new(c"test,device"), ())
>   ///     ]
>   /// );
>   ///
> -/// impl i2c::Driver for MyDriver {
> +/// impl<'a> i2c::Driver<'a> for MyDriver {
>   ///     type IdInfo = ();
>   ///     const I2C_ID_TABLE: Option<i2c::IdTable<Self::IdInfo>> = Some(&I2C_TABLE);
>   ///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
>   ///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
>   ///
>   ///     fn probe(
> -///         _idev: &i2c::I2cClient<Core>,
> -///         _id_info: Option<&Self::IdInfo>,
> -///     ) -> impl PinInit<Self, Error> {
> +///         _idev: &'a i2c::I2cClient<Core>,
> +///         _id_info: Option<&'a Self::IdInfo>,
> +///     ) -> impl PinInit<Self, Error> + 'a {
>   ///         Err(ENODEV)
>   ///     }
>   ///
> -///     fn shutdown(_idev: &i2c::I2cClient<Core>, this: Pin<&Self>) {
> +///     fn shutdown(_idev: &'a i2c::I2cClient<Core>, _this: Pin<&'a Self>) {
>   ///     }
>   /// }
>   ///```
> -pub trait Driver: Send {
> +pub trait Driver<'a>: Send {
>       /// The type holding information about each device id supported by the driver.
>       // TODO: Use `associated_type_defaults` once stabilized:
>       //
> @@ -335,9 +357,9 @@ pub trait Driver: Send {
>       /// Called when a new i2c client is added or discovered.
>       /// Implementers should attempt to initialize the client here.
>       fn probe(
> -        dev: &I2cClient<device::Core>,
> -        id_info: Option<&Self::IdInfo>,
> -    ) -> impl PinInit<Self, Error>;
> +        dev: &'a I2cClient<device::Core>,
> +        id_info: Option<&'a Self::IdInfo>,
> +    ) -> impl PinInit<Self, Error> + 'a;
>   
>       /// I2C driver shutdown.
>       ///
> @@ -350,7 +372,7 @@ fn probe(
>       /// This callback is distinct from final resource cleanup, as the driver instance remains valid
>       /// after it returns. Any deallocation or teardown of driver-owned resources should instead be
>       /// handled in `Self::drop`.
> -    fn shutdown(dev: &I2cClient<device::Core>, this: Pin<&Self>) {
> +    fn shutdown(dev: &'a I2cClient<device::Core>, this: Pin<&'a Self>) {
>           let _ = (dev, this);
>       }
>   
> @@ -364,7 +386,7 @@ fn shutdown(dev: &I2cClient<device::Core>, this: Pin<&Self>) {
>       /// operations to gracefully tear down the device.
>       ///
>       /// Otherwise, release operations for driver resources should be performed in `Self::drop`.
> -    fn unbind(dev: &I2cClient<device::Core>, this: Pin<&Self>) {
> +    fn unbind(dev: &'a I2cClient<device::Core>, this: Pin<&'a Self>) {
>           let _ = (dev, this);
>       }
>   }
> diff --git a/samples/rust/rust_driver_i2c.rs b/samples/rust/rust_driver_i2c.rs
> index 6be79f9e9fb5..f86c1cf7c786 100644
> --- a/samples/rust/rust_driver_i2c.rs
> +++ b/samples/rust/rust_driver_i2c.rs
> @@ -15,25 +15,25 @@
>   kernel::acpi_device_table! {
>       ACPI_TABLE,
>       MODULE_ACPI_TABLE,
> -    <SampleDriver as i2c::Driver>::IdInfo,
> +    <SampleDriver as i2c::Driver<'_>>::IdInfo,
>       [(acpi::DeviceId::new(c"LNUXBEEF"), 0)]
>   }
>   
>   kernel::i2c_device_table! {
>       I2C_TABLE,
>       MODULE_I2C_TABLE,
> -    <SampleDriver as i2c::Driver>::IdInfo,
> +    <SampleDriver as i2c::Driver<'_>>::IdInfo,
>       [(i2c::DeviceId::new(c"rust_driver_i2c"), 0)]
>   }
>   
>   kernel::of_device_table! {
>       OF_TABLE,
>       MODULE_OF_TABLE,
> -    <SampleDriver as i2c::Driver>::IdInfo,
> +    <SampleDriver as i2c::Driver<'_>>::IdInfo,
>       [(of::DeviceId::new(c"test,rust_driver_i2c"), 0)]
>   }
>   
> -impl i2c::Driver for SampleDriver {
> +impl<'a> i2c::Driver<'a> for SampleDriver {
>       type IdInfo = u32;
>   
>       const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
> @@ -41,9 +41,9 @@ impl i2c::Driver for SampleDriver {
>       const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
>   
>       fn probe(
> -        idev: &i2c::I2cClient<Core>,
> -        info: Option<&Self::IdInfo>,
> -    ) -> impl PinInit<Self, Error> {
> +        idev: &'a i2c::I2cClient<Core>,
> +        info: Option<&'a Self::IdInfo>,
> +    ) -> impl PinInit<Self, Error> + 'a {
>           let dev = idev.as_ref();
>   
>           dev_info!(dev, "Probe Rust I2C driver sample.\n");
> @@ -55,11 +55,11 @@ fn probe(
>           Ok(Self)
>       }
>   
> -    fn shutdown(idev: &i2c::I2cClient<Core>, _this: Pin<&Self>) {
> +    fn shutdown(idev: &'a i2c::I2cClient<Core>, _this: Pin<&'a Self>) {
>           dev_info!(idev.as_ref(), "Shutdown Rust I2C driver sample.\n");
>       }
>   
> -    fn unbind(idev: &i2c::I2cClient<Core>, _this: Pin<&Self>) {
> +    fn unbind(idev: &'a i2c::I2cClient<Core>, _this: Pin<&'a Self>) {
>           dev_info!(idev.as_ref(), "Unbind Rust I2C driver sample.\n");
>       }
>   }

Acked-by: Igor Korotin <igor.korotin@linux.dev>

Cheers
Igor

