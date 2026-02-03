Return-Path: <linux-pwm+bounces-8057-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBGrBLYkgmnPPgMAu9opvQ
	(envelope-from <linux-pwm+bounces-8057-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 17:39:18 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A58DC1A8
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 17:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3891E314812A
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Feb 2026 16:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2123D1CAB;
	Tue,  3 Feb 2026 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n7Ei7/gK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90138299927;
	Tue,  3 Feb 2026 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770136138; cv=none; b=EAcHRMl1alMMxmLDndb7IDSUE9ogk/RVGvWRxTtsJwLo10Hv1Ca6XXOfwhp4xBRZTZmJARAQAyuWxnppk0s7XUuO0O935T5KXTBmUXvccIdbtbg4VqxLEdcm3DPgZbjJnJwGkZ6BHlU4VmelrutQfJ5ls4tyCw3CK8UjjW0p/Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770136138; c=relaxed/simple;
	bh=QLM8Cd4lYQ1gk9LxsTCcNODV4GYG29LzN7JYwrYqBvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFMR0pq/AsYiC4cR8Oq1UhYmG58dUa4hFgT6BqLP5XARTO7DRqnxUuczJnpJd33I767J7FUrRCQIB3kMYQ8SXkt0WVWk0kl91eLQGCjz3lShithbYWsdE76zux1tg+iY+/DkI6rCZqwY6SvxFzjQZRDhf8S0wtajU1sHla/Ss5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n7Ei7/gK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89252C16AAE;
	Tue,  3 Feb 2026 16:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770136138;
	bh=QLM8Cd4lYQ1gk9LxsTCcNODV4GYG29LzN7JYwrYqBvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n7Ei7/gK+3w3UVBbUFYUxCIGM74q6ghSuVmLT0GQjrLcpb2DVYFuvyEc4Fg2Oe5BZ
	 9DA+SBIsrifVQiytUfgIkTTc876TPTUpb4vCU0rYb6BFbCe/K45ih3+SEqJQ9E8Vtb
	 O4GGnM46moFdad62LnviYrIFwfSWdEShKShFmqEQ=
Date: Tue, 3 Feb 2026 17:28:55 +0100
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
Message-ID: <2026020315-conch-trickle-2d84@gregkh>
References: <20260203-qcom-socinfo-v2-0-d6719db85637@google.com>
 <20260203-qcom-socinfo-v2-6-d6719db85637@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203-qcom-socinfo-v2-6-d6719db85637@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8057-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 65A58DC1A8
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 03:46:35PM +0000, Matthew Maurer wrote:
> Convert the socinfo driver to Rust for a number of improvements:
> * Accessing IO mapped regions through the IO subsystem, rather than
>   through regular memory accesses.

That's good, but the C code could also be "fixed" to do this, right?

> * Binds the device as an auxiliary device rather than a platform device,
>   ensuring the mapped IO regions cannot be accessed after the smem
>   device is removed.

I'm all for this, but is this really an aux device?  What is the
"parent" device of this aux device?  Where are the "siblings"?  What
does sysfs look like before/after this?

> * Adds bounds-checking to all accesses, hardening against a repeat of
>   CVE-2024-58007

How do you now "know" that the bounds checking is correct?  The C
version also had this, it was just "not correct" :)

And which accesses are you referring to?  From userspace?  From the
kernel?  That CVE looks very odd, it's probably not even a real one and
should be revoked, right?


> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index fef840b5457407a85051ded0e835430dbebfe8bb..dcea2d7f37067b0b6f801b3d2b457422ad9f342c 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -4,6 +4,7 @@
>   * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
>   */
>  
> +#include <linux/auxiliary_bus.h>
>  #include <linux/hwspinlock.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> @@ -279,7 +280,6 @@ struct qcom_smem {
>  	struct hwspinlock *hwlock;
>  
>  	u32 item_count;
> -	struct platform_device *socinfo;
>  	struct smem_ptable *ptable;
>  	struct smem_partition global_partition;
>  	struct smem_partition partitions[SMEM_HOST_COUNT];
> @@ -675,6 +675,32 @@ static void *qcom_smem_get_private(struct qcom_smem *smem,
>  	return ERR_PTR(-EINVAL);
>  }
>  
> +/**
> + * qcom_smem_get_aux() - resolve ptr of size of a smem item
> + * @aux:        an aux device that should be our child
> + * @host:	the remote processor, or -1
> + * @item:	smem item handle
> + * @size:	pointer to be filled out with size of the item
> + *
> + * Looks up smem item and returns pointer to it. Size of smem
> + * item is returned in @size.
> + *
> + * The caller may take the loaded state of the provided aux device as
> + * an acceptable proxy for this memory being valid.
> + *
> + * Return: a pointer to an SMEM item on success, ERR_PTR() on failure.
> + */
> +void *qcom_smem_get_aux(struct auxiliary_device *aux, unsigned int host,
> +		unsigned int item, size_t *size)
> +{
> +	if (IS_ERR(__smem))
> +		return __smem;
> +	if (aux->dev.parent != __smem->dev)
> +		return ERR_PTR(-EINVAL);
> +	return qcom_smem_get(host, item, size);

So you are returning a void pointer?  But don't you really know the
"type" of what is being asked here?  It's a memory chunk, so u8?  Or
something else?  void * feels "rough" here.

> +}
> +EXPORT_SYMBOL_GPL(qcom_smem_get_aux);
> +
>  /**
>   * qcom_smem_get() - resolve ptr of size of a smem item
>   * @host:	the remote processor, or -1
> @@ -684,6 +710,9 @@ static void *qcom_smem_get_private(struct qcom_smem *smem,
>   * Looks up smem item and returns pointer to it. Size of smem
>   * item is returned in @size.
>   *
> + * It is up to the caller to ensure that the qcom_smem device remains
> + * loaded by some mechanism when accessing returned memory.

What do you mean by "loaded"?  You are saying that the caller needs to
rely on this driver remaining in memory for that memory to be "valid"?

If this is the case, why not take a reference count?

> +impl Smem {
> +    pub(crate) fn access<'a>(&'a self, dev: &'a Device<Bound>) -> Option<&'a Mmio> {
> +        if *dev != *self.dev {

How can this ever happen?

thanks,

greg k-h

