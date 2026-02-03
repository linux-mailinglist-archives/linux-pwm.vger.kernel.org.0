Return-Path: <linux-pwm+bounces-8051-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN4pGIoagmmZPAMAu9opvQ
	(envelope-from <linux-pwm+bounces-8051-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 16:55:54 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 04346DB92B
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 16:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4EEFF3029A9D
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Feb 2026 15:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C683BFE46;
	Tue,  3 Feb 2026 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Le/RAiAz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B880190462;
	Tue,  3 Feb 2026 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770134151; cv=none; b=eZqEwI5lerxhRIvjQ51lH5WkqkBjAiGZfdu6T7Z+ibJ6ybQn+wusgCpWzYAR+pQoq+zN5moU4aE3vhQXzVnlXkofJqOYEmRDC8yEzA2Cugaox93nP3Tl6n3iIjm6xCIYc9sf/JvNw/7CHGFc7CrbJidcG7WmB37k53gwepr8NP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770134151; c=relaxed/simple;
	bh=/xUQRy0cArdh67xxYz8tNs4qAGoDCFuISO6r7tmdMFw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=jn7IWnAGKhFOa9plz3vv9eUnTsAX6Odr7mjC8MP25L/WKfKUd46DF29mF1UCHIXTKXYuOZXCTJxfmsIiv/AQwoS97D9/tEHh24cakEGEMvuCPsAwnm5FtqNSbcenQl8y/WysCOTLOwaXIXpaI2nX3598e/22zchK/5GvXlKLAI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Le/RAiAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01758C116D0;
	Tue,  3 Feb 2026 15:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770134151;
	bh=/xUQRy0cArdh67xxYz8tNs4qAGoDCFuISO6r7tmdMFw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Le/RAiAzYp3Wea57YnAAv1R5gQs+iT5aAIy60KbhXOIGj66crsbNB1WcWKjR880yN
	 TwBegG2uib0bt+bwRoetTp1PNLVmOIdsJTGVmAhgcqz325wX5aRJS9JCLiBvUG+XnT
	 GCyJChVCdBnEYrV+rRLw5BkNp2hlTW0NGa5+MaUtlSC5EYU1ZKQYnjkCa3m2UDJlmP
	 iVxdMNMogm6MLpcrJpdq71lWHj3At4J1GGOn9y/TKXdUm+U+ktytK9+ZLclR7JQaRq
	 PfOm4lb6ikMdH7VK1J3avjgOZll86HW9FcvNp8oQdtHixFHE3wQtqaTUQl2icyHyWe
	 Ksmzgq+oyqGvA==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Feb 2026 16:55:44 +0100
Message-Id: <DG5G6NS0ZIPV.DGKUZ2J46AKX@kernel.org>
Subject: Re: [PATCH v2 4/6] rust: auxiliary: Support accessing raw aux
 pointer
Cc: "Bjorn Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Satya Durga Srinivasu Prabhala"
 <satyap@quicinc.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Michal Wilczynski" <m.wilczynski@samsung.com>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Trilok Soni" <tsoni@quicinc.com>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pwm@vger.kernel.org>
To: "Matthew Maurer" <mmaurer@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260203-qcom-socinfo-v2-0-d6719db85637@google.com>
 <20260203-qcom-socinfo-v2-4-d6719db85637@google.com>
In-Reply-To: <20260203-qcom-socinfo-v2-4-d6719db85637@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8051-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,quicinc.com,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,collabora.com,linuxfoundation.org,ffwll.ch,samsung.com,intel.com,vger.kernel.org,lists.linux.dev,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 04346DB92B
X-Rspamd-Action: no action

On Tue Feb 3, 2026 at 4:46 PM CET, Matthew Maurer wrote:
> While it's preferable to add bindings in the kernel crate rather than
> using raw pointers where possible, access to the raw aux pointer is
> required to pass it to C interfaces provided by a driver.
>
> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> ---
>  rust/kernel/auxiliary.rs | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
> index 93c0db1f66555c97ec7dc58825e97c47c0154e54..1a88277f0fd9ea5ff32cc534d=
fe5682009de94c2 100644
> --- a/rust/kernel/auxiliary.rs
> +++ b/rust/kernel/auxiliary.rs
> @@ -237,7 +237,11 @@ pub struct Device<Ctx: device::DeviceContext =3D dev=
ice::Normal>(
>  );
> =20
>  impl<Ctx: device::DeviceContext> Device<Ctx> {
> -    fn as_raw(&self) -> *mut bindings::auxiliary_device {
> +    /// Returns the underlying auxiliary device

"Returns a pointer to the underlying `struct auxiliary_device`."

> +    ///
> +    /// Prefer to add bindings in the kernel crate for any use other tha=
n calling driver-specific
> +    /// functions.

I'm not sure I understand the message of this comment, but I'd probably jus=
t
drop it, the above should be enough.

> +    pub fn as_raw(&self) -> *mut bindings::auxiliary_device {
>          self.0.get()
>      }

