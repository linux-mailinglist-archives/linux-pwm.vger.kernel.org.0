Return-Path: <linux-pwm+bounces-8080-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qM91IbYGg2lLgwMAu9opvQ
	(envelope-from <linux-pwm+bounces-8080-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 04 Feb 2026 09:43:34 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BFFE34A0
	for <lists+linux-pwm@lfdr.de>; Wed, 04 Feb 2026 09:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CB2030C2714
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Feb 2026 08:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF2B39449B;
	Wed,  4 Feb 2026 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zZ9wK3Dd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBB6394490;
	Wed,  4 Feb 2026 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770194303; cv=none; b=GRYg5C00qefcS828bRKavEtk0KdvUoZ4tAFP5ugEN06c+HDQH7Sn2KAB9UcRZUOvY1SZtzRqqxeR3++PPnqBZN4PCA2DaZt1lfn3dSVeNtQeReI+ZTYj3eYKDcKICBOf4M6//grjhCGw81+8MJI1vs3cT0WDZqZvA1s+McxnEEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770194303; c=relaxed/simple;
	bh=lOydLdwq0DJFngTFiPOVACyhCV1v+oLvFmseBRZSl9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pi4xUMG1uxJaVepKlvoO800GJYXJ+qaWvbwC5DzMWtqgZ8GEmTh1BIqagCBXFEEucEVHocZQbL+OSUh7kFWFHKbhcS3AM/EMUIWHnDEoUwGCjHK+/o84Sb7fhXreAB5NzrxEvZmqeFket2JWw4506U1rvUzC3UbX2fbo0y04Hdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zZ9wK3Dd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0149C4CEF7;
	Wed,  4 Feb 2026 08:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770194302;
	bh=lOydLdwq0DJFngTFiPOVACyhCV1v+oLvFmseBRZSl9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zZ9wK3DdZuQtbQgr8kmPZPfHhAnXOknf1rTetfhvDwCRs80vZL19iBD35iTyihxBy
	 MKVki/wCr1XYG5hDoFk3Gn4d1h/VDij2I6C7clzDq1Snl8w66CPI9HxVB9Bp4dxGkl
	 A7EexQ4Ns5AXdzDQO/bOn3TvmrIda650d51zEkGs=
Date: Wed, 4 Feb 2026 09:38:19 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Matthew Maurer <mmaurer@google.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Satya Durga Srinivasu Prabhala <satyap@quicinc.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
	Trilok Soni <tsoni@quicinc.com>, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, rust-for-linux@vger.kernel.org,
	driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 6/6] soc: qcom: socinfo: Convert to Rust
Message-ID: <2026020409-situated-icing-5a1a@gregkh>
References: <20260203-qcom-socinfo-v2-0-d6719db85637@google.com>
 <20260203-qcom-socinfo-v2-6-d6719db85637@google.com>
 <2026020315-conch-trickle-2d84@gregkh>
 <CAGSQo03Ok1sv4myQk2Ch68rET19ypq4Mm-=82Ue-T-2Z8kaGmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGSQo03Ok1sv4myQk2Ch68rET19ypq4Mm-=82Ue-T-2Z8kaGmA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8080-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[kernel.org,quicinc.com,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,collabora.com,ffwll.ch,samsung.com,intel.com,vger.kernel.org,lists.linux.dev,lists.freedesktop.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cve.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 13BFFE34A0
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 09:37:50AM -0800, Matthew Maurer wrote:
> On Tue, Feb 3, 2026 at 8:28 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Feb 03, 2026 at 03:46:35PM +0000, Matthew Maurer wrote:
> > > Convert the socinfo driver to Rust for a number of improvements:
> > > * Accessing IO mapped regions through the IO subsystem, rather than
> > >   through regular memory accesses.
> >
> > That's good, but the C code could also be "fixed" to do this, right?
> 
> Yes, nothing stops the C code from being fixed to do all of this - all
> of this is representable in C code.

Great!  How about sending fixes for that first so that older kernels can
benifit from those fixes :)

> > > * Binds the device as an auxiliary device rather than a platform device,
> > >   ensuring the mapped IO regions cannot be accessed after the smem
> > >   device is removed.
> >
> > I'm all for this, but is this really an aux device?  What is the
> > "parent" device of this aux device?  Where are the "siblings"?  What
> > does sysfs look like before/after this?
> 
> The parent of this aux device is qcom-smem. In the prior
> implementation, qcom-smem loads this device through
> `platform_device_register_data` and `platform_device_unregister`,
> holding a reference in its global struct to release it when being
> released. The probe table for the qcom-socinfo driver was empty, so it
> would not probe without an explicit registration.

So it's a "fake" platform device being created?  As Bjorn said, moving
this to aux today would probably be good first.

> > > * Adds bounds-checking to all accesses, hardening against a repeat of
> > >   CVE-2024-58007
> >
> > How do you now "know" that the bounds checking is correct?  The C
> > version also had this, it was just "not correct" :)
> 
> While it's technically possible for the Rust code to have an error
> here, the error would not be in the driver, but in the kernel crate.
> The advantage here is that the bounds checking is all centralized, so
> we get it right once, for the entire kernel, instead of needing to get
> it right every time.

I missed where the bounds checking is happening at all here.  I see
fields and sizes of fields, but what is verifying that those sizes are
actually correct?

> > And which accesses are you referring to?  From userspace?  From the
> > kernel?  That CVE looks very odd, it's probably not even a real one and
> > should be revoked, right?
> >
> 
> That CVE looks like this:
> 1. qcom_smem_get returns an object of size N
> 2. When initializing the `serial_number` field of
> soc_device_attributes, the offset of the serial number field was
> checked as <= N, rather than the *end* of the serial number field.
> 3. This resulted in the driver exposing through sysfs whatever data
> was mapped afterwards, interpreted as a number.
> 
> I agree that the severity seems oddly high, given that in practice,
> this will expose the remainder of the IO mapped page - I don't believe
> it crosses a page boundary, so it can't even *really* leak anything.

Where do you see this as "high"?  The kernel CNA does NOT give any
severity info for any CVEs that are issued.

If you are looking at the crap that NVD adds, well, it's just that,
crap, that has no actual relevance to anyone and is flat out wrong most
of the time.  We have asked them to stop doing this, but so far we have
not gotten a response:
	https://github.com/cisagov/vulnrichment/issues/262

In short, for kernel CVEs only look at the data provided by cve.org, or
the raw data provided by the kernel CNA team.

That being said, this seems like a basic "we are just displaying wrong
data in a sysfs file", so it probably should be rejected unless someone
can tell me how it fits the definition of a vulnerability?

As for why it's a CVE at all, it came in as part of the required GSD
import into CVE.org.

> > > +void *qcom_smem_get_aux(struct auxiliary_device *aux, unsigned int host,
> > > +             unsigned int item, size_t *size)
> > > +{
> > > +     if (IS_ERR(__smem))
> > > +             return __smem;
> > > +     if (aux->dev.parent != __smem->dev)
> > > +             return ERR_PTR(-EINVAL);
> > > +     return qcom_smem_get(host, item, size);
> >
> > So you are returning a void pointer?  But don't you really know the
> > "type" of what is being asked here?  It's a memory chunk, so u8?  Or
> > something else?  void * feels "rough" here.
> >
> > > +}
> > > +EXPORT_SYMBOL_GPL(qcom_smem_get_aux);
> > > +
> > >  /**
> > >   * qcom_smem_get() - resolve ptr of size of a smem item
> > >   * @host:    the remote processor, or -1
> > > @@ -684,6 +710,9 @@ static void *qcom_smem_get_private(struct qcom_smem *smem,
> > >   * Looks up smem item and returns pointer to it. Size of smem
> > >   * item is returned in @size.
> > >   *
> > > + * It is up to the caller to ensure that the qcom_smem device remains
> > > + * loaded by some mechanism when accessing returned memory.
> >
> > What do you mean by "loaded"?  You are saying that the caller needs to
> > rely on this driver remaining in memory for that memory to be "valid"?
> >
> > If this is the case, why not take a reference count?
> >
> > > +impl Smem {
> > > +    pub(crate) fn access<'a>(&'a self, dev: &'a Device<Bound>) -> Option<&'a Mmio> {
> > > +        if *dev != *self.dev {
> >
> > How can this ever happen?

I think you missed these review comments?

thanks,

greg k-h

