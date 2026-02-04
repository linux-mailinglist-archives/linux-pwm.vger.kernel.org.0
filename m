Return-Path: <linux-pwm+bounces-8081-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPHuEeAGg2lLgwMAu9opvQ
	(envelope-from <linux-pwm+bounces-8081-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 04 Feb 2026 09:44:16 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AEBE34B8
	for <lists+linux-pwm@lfdr.de>; Wed, 04 Feb 2026 09:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46BB330401A8
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Feb 2026 08:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D748F39448F;
	Wed,  4 Feb 2026 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gF3JseDv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC531D63F0;
	Wed,  4 Feb 2026 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770194411; cv=none; b=RncT6QZr3kFv5nmaMEdHyeKWVX55HQUnrziok6QVXNktverdH78bdonf3oHVkPcMbcNzm9iWoot8TSfTwE48mg/VZZ8tMs6CDM4ZrW3utxB+Iw6t9eHZxKoazPT32xhGY+GUBTsgwDMaCdCyneH21mziI2CdOmuYK8CWxmmaQNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770194411; c=relaxed/simple;
	bh=ieoxqjYocsy+D21C36yTN1myUqFUsHGgVBpKNl7asbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFW6bgjn58ojOR75YqWH3mN/BAKaHwJhtv1O49+Yslx4NSkV/C6C9pi8BrjFGWnWNe/8Gel+G06y/Zz2qscDVOvMxYeLEC6VUMSPYC/MyyvrCsTtjK67XhNuo+ZaQt0TPsBvS1kNJ5Prsf039jqIDNjTjDfdg21YOMtHLMJhkjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gF3JseDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5ECC4CEF7;
	Wed,  4 Feb 2026 08:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770194411;
	bh=ieoxqjYocsy+D21C36yTN1myUqFUsHGgVBpKNl7asbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gF3JseDvBu57Tja7xeL1EFQKpmvn61dQu7HKgKMBHyKt9LPKouJYAsLOv+ztErWwc
	 CWaICOxWHobZKWX/oQIcSdQVrjsSP9bMas7icS+lPyU+QQXXyRSb+uN251yReaPbcy
	 BxckdydqWniU+1pMfse2te9Suu4Eo8tke/5tdiSw=
Date: Wed, 4 Feb 2026 09:40:07 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Matthew Maurer <mmaurer@google.com>,
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
Message-ID: <2026020436-mascot-parachute-81da@gregkh>
References: <20260203-qcom-socinfo-v2-0-d6719db85637@google.com>
 <20260203-qcom-socinfo-v2-6-d6719db85637@google.com>
 <366n5psgnyptd2unf4mb2lniqfkc7n4oqbeg7oopktudwepatb@aj5bqkvt375i>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <366n5psgnyptd2unf4mb2lniqfkc7n4oqbeg7oopktudwepatb@aj5bqkvt375i>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8081-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[google.com,kernel.org,quicinc.com,gmail.com,garyguo.net,protonmail.com,umich.edu,collabora.com,ffwll.ch,samsung.com,intel.com,vger.kernel.org,lists.linux.dev,lists.freedesktop.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C5AEBE34B8
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 02:27:21PM -0600, Bjorn Andersson wrote:
> I expressed my scepticism in v1 about changing this driver, for the sake
> of supporting this experiment in your downstream kernel(s). The people
> who suggested this driver to be a good candidate choose not to engage in
> either that discussion nor in the review of the solution itself.

I was told that QCOM wanted this driver to be redone in rust as that is
what they wanted to do for further socinfo drivers going forward.
Hopefully the people that said that actually talked to the kernel
developers/maintainers involved in this driver first before doing so :)

thanks,

greg k-h

