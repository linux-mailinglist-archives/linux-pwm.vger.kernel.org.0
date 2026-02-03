Return-Path: <linux-pwm+bounces-8072-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLHhHDs0gmlTQgMAu9opvQ
	(envelope-from <linux-pwm+bounces-8072-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 18:45:31 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE17DD06F
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 18:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43E3A30E70B3
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Feb 2026 17:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5188F326923;
	Tue,  3 Feb 2026 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0j6yyqgN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7040B3033FB
	for <linux-pwm@vger.kernel.org>; Tue,  3 Feb 2026 17:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770140288; cv=pass; b=KvUj7GWzcLJBe9qEnA6/Yw/4XfLUVhVee9MmqaSQt+PFll8Cw75WHYADCpk5nliYkoVLterOtXmTYJjabi14zSbTl0xSY+I5shTxv9wsHsZTG15BbupcEpR9wWokQ/AeZvRGPXLCIIA2mLgIRHz4WPLz291TWW6PZAt0d7pNvTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770140288; c=relaxed/simple;
	bh=4YzknxHBfsROI3oe/0Gw8Zry6luJZkfAyc2iFek3R2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CeccdDFj2lHQl8xguah6xyPx3VZQgnqga3aWz9iFhLuHmeUS4IacqyXejFJsfZkkom2K2g/LUwtdBpuoOxpwQZNM4vat/hE+f9vJmtasj9MTHuxu3QGvIPBDXufQjIn/MPWqmPB9PDOCrvalti6nFkWJYqATtOIfgT1E4TYDGeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0j6yyqgN; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-652fe3bf65aso12160a12.1
        for <linux-pwm@vger.kernel.org>; Tue, 03 Feb 2026 09:38:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770140285; cv=none;
        d=google.com; s=arc-20240605;
        b=Gj6pR4stoKG8DYHBPePax7XYBJEsnJx0pglzsccgOaIJRrOtSUErRI7MDCFRqIzRX5
         kgVC+m1yTIjIXBRmG1FaGIXxI8SwFhpI97mp0rQhJa8NVPCo12rH8SurdRtpcL3PAyl8
         1RIMG+BpENj9/SBUrA6xX7urX4817msqGM8VvByGvZGhmOvd/6cYRd1+1f7Ji/w93RL/
         KxG4TJCgjzxGlbZQIXG/92kfknB8jbdzLujWq93tQ1gpHDwn/2FRAr5u0m1w28cxMWuJ
         ImmIN/WpoUzb9mL0+WbJuSsQrhyD+rbvkB7JYMEbdWmE8dIJKYVetf4pqkCjli3fYpRJ
         u9sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j4q33YjRLQ15ajYRux/jBaFbRViw55ylugUQtfD14xM=;
        fh=kTNAtBsv/IR5WYOYtdtS8EpwaCOyYDe6Q2BgPORmOs0=;
        b=IRrUZs3uyHECGCLD4X8HjMSNgOIUlcGpg2VpMF+yfuBvaYRi7/GGszIA9UMsUJVWPK
         7lRN5UXFgkM4wqKqchvQyK93lBdRVOJ/TO/FaiqoPLDyJTrOzBDsT1EXq6lOmMHbu+DW
         8Gv/pl7ntd1JjXdbuG5UKWoltzZqSDATX3WpsvHHRD0rq7o0xDqsWIwI5VUiITXCYAfQ
         OAHGHpRmo5B9If+7A1qcge+dun1f3OcCTP+meWC2OhEI7VvBUt3n7035cZcGhb/G1PrX
         3HPIf+PyJ7Uueq9PxtSG9noaN01+j0w8Gz3+YvuLvKhmIhP6dhwkFP28+zbHMfadjw+w
         tiug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770140285; x=1770745085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4q33YjRLQ15ajYRux/jBaFbRViw55ylugUQtfD14xM=;
        b=0j6yyqgNgfMuyQjAhaiZKIEp76zEYzKPM7YtpLIPKFoJRpL2eeHqQTfXu2kippPwrl
         9AUpt6POE/3ryJYTH9PjKRHhv1wZ1dKD7nZ+0/dcbKmlpKz+22q571dOV2ZA4Vv8hSjE
         jyVcOTpT/xMFALZ6h/rbSouqDalRfUOlYOlB/xtJ7aCvl5vpTZUpNTcikPiAvhVqTTwl
         kKw33KIt2eNk3/Ts9mzJjCAovvyP7yxZJc59t+f5cPW0Yno9QsAt1F8MZMUb3QMRp8JX
         zdDgDAYR2iSO/l3vgq539E6fBsYhQTDelvk9EW9cYOfxd+ScXREVhzxZ/KPL8VMiAZFT
         6oJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770140285; x=1770745085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j4q33YjRLQ15ajYRux/jBaFbRViw55ylugUQtfD14xM=;
        b=OS9Icu1aHyeIJBjF25ISutGS3ESxEp0UJLk11llrn59OejaML742tHNjJPzArPt/EW
         H61Ykv6+eEsrp7z1VcP3avn25TvF7utXHMcEXECIZ14jHgQ5LJNAskMCbvljYDq0e+sb
         AT75Y3FEpMsil76h2VEh50RJgy8vxI0zyf208nz+ZDxKi7PucaBp3Oxj3dhPhk/M/WcB
         kD5G8xkzGC0RtErxL1MO3oREJBUQghJgxcfqJLHDDHI29OWTb5tJMQvxRXC0l4iOlkKH
         hF3KPtPDxgnv8lP385stj0fgAW+7rAbVD65KqltrPDO/j2Ifm4PVpFd7KMleen5dYc/8
         DuPA==
X-Forwarded-Encrypted: i=1; AJvYcCW4KZ9/NnrUv4XjUQDA40Kci7fd9ztAFFER67g5GCPMuA/ZjLUwy0ln2ceGxc9Ao7fDbbmEa52BVmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCZ7OWKJFjKH08XXJYO8B5sdcWWjiwL9kkoJgPhEtcs78vx/E/
	RP5I1vKwbXG2TfT2P3JXF+06YwcuQv9yt9Gdwo8/TOvloVQyMPVZi1NrbMb7n2Gn5huStgIwauP
	aIGFs0r4nGJlsJL5JYXb7rtSSISGQQNWVxe1EKYOz
X-Gm-Gg: AZuq6aKfWlrMfGYW6A9NJAEbYfmFm4eFZuseUAQDP9G2YZvynZmn5uIeXErmb17T3H8
	S0aWuVK25l36l4aR61CUhdDKGCT/f2RxCIA57C3K1rkqMaLei5y+fbJ+tY09z949TcBKj9nMSTc
	82M+yncf/SzLyXK35NrHMvorguxgbJdVrDPrE0yXSzwLXtbaBKQNG1BKnn5mbvqtQsF+7UlEvMp
	Xr5f1ay/E9arrJw0CmiziuIHTodRMKkyxXN9KHwdzA1x2tIOdJUB0SUQub4drtbDZlOr3mlJaG8
	H6QJVx/kYTgWzmmoQvz1LSS0NQ==
X-Received: by 2002:aa7:d355:0:b0:658:bd2d:929c with SMTP id
 4fb4d7f45d1cf-6594a33abd0mr5612a12.12.1770140284581; Tue, 03 Feb 2026
 09:38:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203-qcom-socinfo-v2-0-d6719db85637@google.com>
 <20260203-qcom-socinfo-v2-6-d6719db85637@google.com> <2026020315-conch-trickle-2d84@gregkh>
In-Reply-To: <2026020315-conch-trickle-2d84@gregkh>
From: Matthew Maurer <mmaurer@google.com>
Date: Tue, 3 Feb 2026 09:37:50 -0800
X-Gm-Features: AZwV_Qib0Xwq7jvSK8YoP13KkCRLNUErONN49KXCI4YsJMCfMFPdjadu_r-_mhs
Message-ID: <CAGSQo03Ok1sv4myQk2Ch68rET19ypq4Mm-=82Ue-T-2Z8kaGmA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] soc: qcom: socinfo: Convert to Rust
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Satya Durga Srinivasu Prabhala <satyap@quicinc.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, Trilok Soni <tsoni@quicinc.com>, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8072-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[kernel.org,quicinc.com,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,collabora.com,ffwll.ch,samsung.com,intel.com,vger.kernel.org,lists.linux.dev,lists.freedesktop.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmaurer@google.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 0BE17DD06F
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 8:28=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Feb 03, 2026 at 03:46:35PM +0000, Matthew Maurer wrote:
> > Convert the socinfo driver to Rust for a number of improvements:
> > * Accessing IO mapped regions through the IO subsystem, rather than
> >   through regular memory accesses.
>
> That's good, but the C code could also be "fixed" to do this, right?

Yes, nothing stops the C code from being fixed to do all of this - all
of this is representable in C code.

>
> > * Binds the device as an auxiliary device rather than a platform device=
,
> >   ensuring the mapped IO regions cannot be accessed after the smem
> >   device is removed.
>
> I'm all for this, but is this really an aux device?  What is the
> "parent" device of this aux device?  Where are the "siblings"?  What
> does sysfs look like before/after this?

The parent of this aux device is qcom-smem. In the prior
implementation, qcom-smem loads this device through
`platform_device_register_data` and `platform_device_unregister`,
holding a reference in its global struct to release it when being
released. The probe table for the qcom-socinfo driver was empty, so it
would not probe without an explicit registration.

>
> > * Adds bounds-checking to all accesses, hardening against a repeat of
> >   CVE-2024-58007
>
> How do you now "know" that the bounds checking is correct?  The C
> version also had this, it was just "not correct" :)

While it's technically possible for the Rust code to have an error
here, the error would not be in the driver, but in the kernel crate.
The advantage here is that the bounds checking is all centralized, so
we get it right once, for the entire kernel, instead of needing to get
it right every time.

>
> And which accesses are you referring to?  From userspace?  From the
> kernel?  That CVE looks very odd, it's probably not even a real one and
> should be revoked, right?
>

That CVE looks like this:
1. qcom_smem_get returns an object of size N
2. When initializing the `serial_number` field of
soc_device_attributes, the offset of the serial number field was
checked as <=3D N, rather than the *end* of the serial number field.
3. This resulted in the driver exposing through sysfs whatever data
was mapped afterwards, interpreted as a number.

I agree that the severity seems oddly high, given that in practice,
this will expose the remainder of the IO mapped page - I don't believe
it crosses a page boundary, so it can't even *really* leak anything.

>
> > diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> > index fef840b5457407a85051ded0e835430dbebfe8bb..dcea2d7f37067b0b6f801b3=
d2b457422ad9f342c 100644
> > --- a/drivers/soc/qcom/smem.c
> > +++ b/drivers/soc/qcom/smem.c
> > @@ -4,6 +4,7 @@
> >   * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
> >   */
> >
> > +#include <linux/auxiliary_bus.h>
> >  #include <linux/hwspinlock.h>
> >  #include <linux/io.h>
> >  #include <linux/module.h>
> > @@ -279,7 +280,6 @@ struct qcom_smem {
> >       struct hwspinlock *hwlock;
> >
> >       u32 item_count;
> > -     struct platform_device *socinfo;
> >       struct smem_ptable *ptable;
> >       struct smem_partition global_partition;
> >       struct smem_partition partitions[SMEM_HOST_COUNT];
> > @@ -675,6 +675,32 @@ static void *qcom_smem_get_private(struct qcom_sme=
m *smem,
> >       return ERR_PTR(-EINVAL);
> >  }
> >
> > +/**
> > + * qcom_smem_get_aux() - resolve ptr of size of a smem item
> > + * @aux:        an aux device that should be our child
> > + * @host:    the remote processor, or -1
> > + * @item:    smem item handle
> > + * @size:    pointer to be filled out with size of the item
> > + *
> > + * Looks up smem item and returns pointer to it. Size of smem
> > + * item is returned in @size.
> > + *
> > + * The caller may take the loaded state of the provided aux device as
> > + * an acceptable proxy for this memory being valid.
> > + *
> > + * Return: a pointer to an SMEM item on success, ERR_PTR() on failure.
> > + */
> > +void *qcom_smem_get_aux(struct auxiliary_device *aux, unsigned int hos=
t,
> > +             unsigned int item, size_t *size)
> > +{
> > +     if (IS_ERR(__smem))
> > +             return __smem;
> > +     if (aux->dev.parent !=3D __smem->dev)
> > +             return ERR_PTR(-EINVAL);
> > +     return qcom_smem_get(host, item, size);
>
> So you are returning a void pointer?  But don't you really know the
> "type" of what is being asked here?  It's a memory chunk, so u8?  Or
> something else?  void * feels "rough" here.
>
> > +}
> > +EXPORT_SYMBOL_GPL(qcom_smem_get_aux);
> > +
> >  /**
> >   * qcom_smem_get() - resolve ptr of size of a smem item
> >   * @host:    the remote processor, or -1
> > @@ -684,6 +710,9 @@ static void *qcom_smem_get_private(struct qcom_smem=
 *smem,
> >   * Looks up smem item and returns pointer to it. Size of smem
> >   * item is returned in @size.
> >   *
> > + * It is up to the caller to ensure that the qcom_smem device remains
> > + * loaded by some mechanism when accessing returned memory.
>
> What do you mean by "loaded"?  You are saying that the caller needs to
> rely on this driver remaining in memory for that memory to be "valid"?
>
> If this is the case, why not take a reference count?
>
> > +impl Smem {
> > +    pub(crate) fn access<'a>(&'a self, dev: &'a Device<Bound>) -> Opti=
on<&'a Mmio> {
> > +        if *dev !=3D *self.dev {
>
> How can this ever happen?
>
> thanks,
>
> greg k-h

