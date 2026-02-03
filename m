Return-Path: <linux-pwm+bounces-8056-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAz/Kp4fgmmhPQMAu9opvQ
	(envelope-from <linux-pwm+bounces-8056-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 17:17:34 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 259A8DBC73
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 17:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 085C13007674
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Feb 2026 16:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BEF3B961B;
	Tue,  3 Feb 2026 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K7PxGaVp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E62E22B594;
	Tue,  3 Feb 2026 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135452; cv=none; b=OIi4aVmn7zoIlkXzJjEOBPyZMPbmYNIANTDBOVl1yLA4rBlm27TaIQKwGWi9cxR6gVRRng6xkJlMou6fYcXgSo4CDkzXGBCT+WtMXoMUkmrLiw7r6XO4nu6/OsvOdQjb96TVbMaxMqoITpZRHFr3O2RCBdRi5CEvuwqjzR/P5Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135452; c=relaxed/simple;
	bh=Y5GCQ53SPa0Arre4QKWM7rqqfYEk92SpOKdkmzkB/sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cf6up5o0mEkwXqWTMc66R0GWuoZtdWMWDY+focy6EEuJTOMPWfLEZVYRicCQEgtQ06UxkyV02S2Cv3xpzTKSq6qnaVdT4SXeTwgl0Ma8SZENSIAgy5n05lCg0k58lPoLbiVShFcyUuueUE0THvUFkRWckks6YbJzSdTgGWC/bQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K7PxGaVp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47725C116D0;
	Tue,  3 Feb 2026 16:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770135451;
	bh=Y5GCQ53SPa0Arre4QKWM7rqqfYEk92SpOKdkmzkB/sA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K7PxGaVpkAZn7aly4ZMsjZhSYTnF4SyjU8VoRi2Vhbpg881m+qfI1FT4LJo8z9XiC
	 D44AcpGlVQa/p93cPsgwNmjTs5KKQuUdWvGW9iSA8uxUDz5/0huFWLGZ6OjELXvkoa
	 NEG4D3mW7+IFrkRCQpGqDfd7X5vWtHVHaGpPnzAc=
Date: Tue, 3 Feb 2026 17:17:28 +0100
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
Subject: Re: [PATCH v2 3/6] rust: device: Support testing devices for equality
Message-ID: <2026020338-gratitude-overplay-98b0@gregkh>
References: <20260203-qcom-socinfo-v2-0-d6719db85637@google.com>
 <20260203-qcom-socinfo-v2-3-d6719db85637@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203-qcom-socinfo-v2-3-d6719db85637@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8056-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 259A8DBC73
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 03:46:32PM +0000, Matthew Maurer wrote:
> This allows device drivers to check if, for example, an auxiliary
> devices is one of its children by comparing the parent field, or
> checking if a device parameter is its own device.
> 
> Also convert existing `.as_raw() != .as_raw()` to  use this new
> implementation.

Ah, ok, I can see how getting rid of the as_raw() calls here is a "good
thing", but overall it's just the same code paths :)

And I don't see what patch in this series uses this, am I missing it?

thanks,

greg k-h

