Return-Path: <linux-pwm+bounces-8061-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GQ1FhsmgmnPPgMAu9opvQ
	(envelope-from <linux-pwm+bounces-8061-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 17:45:15 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB9EDC2C6
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 17:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B3FA302EA80
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Feb 2026 16:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A74350A33;
	Tue,  3 Feb 2026 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nqgV1DFv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E98822339;
	Tue,  3 Feb 2026 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770136831; cv=none; b=oovn6wufFO/mGyqIiX7cd9Hp41MYllv7oYgYh9RWGtenV88C9bzsO8WSSXKWpB/aS7IILfCZ4ISA4ddcdFJH16jkBw6FKGaajlBDNs4hC9jhWaMgeoLr5XrNN1MteM/t+GWP0e2OXyvaK58VDlFF0DeNRO7jcb49jgCWtts/hWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770136831; c=relaxed/simple;
	bh=aZrOFWbYL/CIDgy9O+tBoiAZFqwv81jbqu1pKEIQ/s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfcPPPhu0pYXDjHr6sGLcTE0xqqM458o/nMt/2eD89iAhbWViXS39ktk9kcBPoKZ6uUbs0GrdMJ3eQu9QaW5X08tmIUsazC/BN80ds2+qZUOdQ/FOSbLC+y5hQNAW0rHDpZPo9ShEtVDjYcQUnKiA/rHK1P3+C6xphFLmdaFxmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nqgV1DFv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DF3C116D0;
	Tue,  3 Feb 2026 16:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770136830;
	bh=aZrOFWbYL/CIDgy9O+tBoiAZFqwv81jbqu1pKEIQ/s8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nqgV1DFvdCPf52Jr2RfRF98OglnYWvCNHNFUFRPA0vBT6Rc6KcxkDcqWxMFLNsg2l
	 dhtBRY60gxsiJRihJhUqj2qAvVshgOSLCcV5nzSrF8HYVozyoHERceTh2FtXRbjOe1
	 UGdLg51T+4PDawREdFlxBc9MdhKPrVNrHco97cMQ=
Date: Tue, 3 Feb 2026 17:40:27 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Maurer <mmaurer@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Satya Durga Srinivasu Prabhala <satyap@quicinc.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
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
Subject: Re: [PATCH v2 3/6] rust: device: Support testing devices for equality
Message-ID: <2026020342-dime-sharply-3fd4@gregkh>
References: <20260203-qcom-socinfo-v2-0-d6719db85637@google.com>
 <20260203-qcom-socinfo-v2-3-d6719db85637@google.com>
 <2026020338-gratitude-overplay-98b0@gregkh>
 <DG5GWC5MR1ZC.3VFVRL0G0NMUW@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DG5GWC5MR1ZC.3VFVRL0G0NMUW@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8061-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,quicinc.com,gmail.com,garyguo.net,protonmail.com,umich.edu,collabora.com,ffwll.ch,samsung.com,intel.com,vger.kernel.org,lists.linux.dev,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BBB9EDC2C6
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 05:29:16PM +0100, Danilo Krummrich wrote:
> On Tue Feb 3, 2026 at 5:17 PM CET, Greg Kroah-Hartman wrote:
> > And I don't see what patch in this series uses this, am I missing it?
> 
> 	impl Smem {
> 	    pub(crate) fn access<'a>(&'a self, dev: &'a Device<Bound>) -> Option<&'a Mmio> {
> 	        if *dev != *self.dev {
> 	            return None;
> 	        }
> 	
> 	        // SAFETY: By our invariant, this was a subrange of what was returned by smem_aux_get, for
> 	        // self.dev, and by our above check, that auxdev is still available.
> 	        Some(unsafe { Mmio::from_raw(&self.raw) })
> 	    }
> 	}
> 
> It's used to ensure that the Smem provided by the auxiliary parent can only be
> accessed as long as the auxiliary parent device is bound.

But how can a parent device ever bevome "unbound"?  A child can always
rely on its parent being present (some odd scsi devices are the one
exception, that mess is hell at times...)

thanks,

greg k-h

