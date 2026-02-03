Return-Path: <linux-pwm+bounces-8062-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCwLFpwngmnPPgMAu9opvQ
	(envelope-from <linux-pwm+bounces-8062-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 17:51:40 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9343DC49B
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 17:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC79231192FE
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Feb 2026 16:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18053D6483;
	Tue,  3 Feb 2026 16:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRTMR4oN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92743D3489;
	Tue,  3 Feb 2026 16:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770137206; cv=none; b=FrL/TGietCKcd6g+ZWcxTxAhZBdBb37VpS4DcBnhJ1tZ6niq/zDuXs+pdsAVKTCSr7sxI8kdNRwD0kdda/xELxjJSLP1JrqYD0pWtpRgQUHBw6PJI9KMwFEHpdBWGSqZ136UyUsWgYCGQcV7Nf4YmsExCh+S+iqIw9SpJlWtxWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770137206; c=relaxed/simple;
	bh=SN3mq4DneEguOI8zzgWysg+fcRGURMTHTYxbyoFa1/M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=quP+sv5YIN9ngrUz7BxhuYwqkpynLt7iiGT+zigcCSu/V5V4So4yVNNJPATh8BTgKDzIPcyWhTgtONcGgHcQaLxHHjZPtCiHayLgz9vf2iMMRtS/xgmzJxc/Ho3O5ZdikIeu/xo74h6R9Q+cMGboOaevSjIhyceWbBdHonYTvWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRTMR4oN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F66BC2BCB7;
	Tue,  3 Feb 2026 16:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770137206;
	bh=SN3mq4DneEguOI8zzgWysg+fcRGURMTHTYxbyoFa1/M=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=MRTMR4oNnQwjKFji63iZnjCbODzO67FUaFCb82HB3Bg1qRDJ5K2FaflXFWUVS6Le/
	 5aDwl3Ze0/50Lr9lNN5mg7rvfhZK4kXAZRQdNIA3pmcQ1JprqxDQtfkm63kPF774kX
	 b0eDwwNZfHLAMLfa8q6pAjhoyNMLe3NP7EesSqqwh0Sl+mQ6Rblj3jQlT2PljwSJKX
	 cCUdEfvMh/HSp5Jx5YxGOIMOc4/fwjz/LK5glYHcmc6LkpDozYtaKvxXaGSwebzdBv
	 CU6SERbxxptO48aTaV0nw+/FuYnWJ+H7HLGtTkfzAavwwZ1eVEPAclrFpsxaNaVySA
	 M51SqFPMP4F5A==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Feb 2026 17:46:39 +0100
Message-Id: <DG5H9N9QKZUW.3KLJW09OBNRD0@kernel.org>
Subject: Re: [PATCH v2 3/6] rust: device: Support testing devices for
 equality
Cc: "Matthew Maurer" <mmaurer@google.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>, "Satya
 Durga Srinivasu Prabhala" <satyap@quicinc.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Michal Wilczynski" <m.wilczynski@samsung.com>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Trilok Soni" <tsoni@quicinc.com>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pwm@vger.kernel.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260203-qcom-socinfo-v2-0-d6719db85637@google.com>
 <20260203-qcom-socinfo-v2-3-d6719db85637@google.com>
 <2026020338-gratitude-overplay-98b0@gregkh>
 <DG5GWC5MR1ZC.3VFVRL0G0NMUW@kernel.org>
 <2026020342-dime-sharply-3fd4@gregkh>
In-Reply-To: <2026020342-dime-sharply-3fd4@gregkh>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8062-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,kernel.org,quicinc.com,gmail.com,garyguo.net,protonmail.com,umich.edu,collabora.com,ffwll.ch,samsung.com,intel.com,vger.kernel.org,lists.linux.dev,lists.freedesktop.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.234.253.10:from];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pwm];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,10.30.226.201:received];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D9343DC49B
X-Rspamd-Action: no action

On Tue Feb 3, 2026 at 5:40 PM CET, Greg Kroah-Hartman wrote:
> On Tue, Feb 03, 2026 at 05:29:16PM +0100, Danilo Krummrich wrote:
>> On Tue Feb 3, 2026 at 5:17 PM CET, Greg Kroah-Hartman wrote:
>> > And I don't see what patch in this series uses this, am I missing it?
>>=20
>> 	impl Smem {
>> 	    pub(crate) fn access<'a>(&'a self, dev: &'a Device<Bound>) -> Optio=
n<&'a Mmio> {
>> 	        if *dev !=3D *self.dev {
>> 	            return None;
>> 	        }
>> =09
>> 	        // SAFETY: By our invariant, this was a subrange of what was re=
turned by smem_aux_get, for
>> 	        // self.dev, and by our above check, that auxdev is still avail=
able.
>> 	        Some(unsafe { Mmio::from_raw(&self.raw) })
>> 	    }
>> 	}
>>=20
>> It's used to ensure that the Smem provided by the auxiliary parent can o=
nly be
>> accessed as long as the auxiliary parent device is bound.
>
> But how can a parent device ever bevome "unbound"?

It can't, that's why auxiliary::Device::parent() returns a &Device<Bound>, =
i.e.
as long as the child is bound the parent is guaranteed to be bound as well.

The point in this implementation is that we need to prove to the resource
container (Smem) that we are allowed to access the resource, since it is on=
ly
valid to access for the duration the parent is bound.

In the end this is equivalent to Devres::access(), which bypasses the Revoc=
able
if we can prove that we are in a &Device<Bound> scope.

Having that said, the code should probably just use Devres instead. :)

