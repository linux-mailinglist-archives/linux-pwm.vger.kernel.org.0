Return-Path: <linux-pwm+bounces-9113-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GH17HBg7FGpDLAcAu9opvQ
	(envelope-from <linux-pwm+bounces-9113-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 14:05:44 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7ED25CA434
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 14:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 995C6300E3C6
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 12:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B873806B6;
	Mon, 25 May 2026 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H46V06tl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BBC37DE9F;
	Mon, 25 May 2026 12:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779710741; cv=none; b=o752p/tUL20kO8fYyQRRO92DEgBq83nVupD494x8smz+BQoUxlqImGnvAEiaD/62yXenvtZtmAJNfVqlQ0GcCCh2e8oPAyswPMKA2dSw1jdQLe4Mx9MTpnoyf5IX9GB6fqmjyYg+Z4guDNtQoFxvb9FnyFnHxWvc9UA7llFiRF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779710741; c=relaxed/simple;
	bh=QQ+RZJGh8DWH5kFovbz1NpBQqzIxDynlHNya2gERhGk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=lTmsj2nj7Hospt+YwxJLOIK55enzvfznpkD5Tbe2uNJFFW4PuEHk+nyWPq5qyNFLkDqZQV5GsraEUk/odvT7hHQ6A715x5BOn1a3bZcx2/8Sb1K1Fl2UTvkPFo/VzQ8ZSBm03RnNmpUad7zgFF1ylUruShQSZt/Jc9ud2ouj+4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H46V06tl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6301F000E9;
	Mon, 25 May 2026 12:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779710740;
	bh=8Nk9IRpfjFpPpcX3RiYgN+W6i/7+f2+AyfDzqFLXzt0=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To;
	b=H46V06tlanS3w6FJpaYnHysMTaAdRs09nAhIdviag/qtWU5rAZ+SebBBlXCd+k1ki
	 IIjWlnwI7wRGB2HeaEyW+yvEeHzY3gfgcaqdcRkQkgLsYc2vEAsWl/Jo5O/qk9E5Up
	 LHPptJzP0wih50NohTPP+q8EeLNjy544KS6V2dT715q06s0c0An/YJOk7ONQDnsvoH
	 2klWQ5GJ0DC4oExrsjEUszN/1/Qd+cH7difkpY3G5N4vs1HHWruW0hzXBZmyk6wvYN
	 wJVKSb7pm5tbUn6fne/9LsJYQo8swAcJ8IT3Oox0CTOiGcgia2SDQmrCoAm2w2yofX
	 QsbiWVqMSpgnw==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 May 2026 14:05:32 +0200
Message-Id: <DIRQSVO5H9X6.VG0RGGPYVWU9@kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v4 17/27] rust: pci: make Bar lifetime-parameterized
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
References: <20260521233501.1191842-1-dakr@kernel.org>
 <20260521233501.1191842-18-dakr@kernel.org>
 <DIRHA02BRA92.32YSMYYL2QBIG@nvidia.com>
 <DIRQA2JNXAHY.2TVOL7GYSHM3V@garyguo.net>
In-Reply-To: <DIRQA2JNXAHY.2TVOL7GYSHM3V@garyguo.net>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9113-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,linuxfoundation.org,kernel.org,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.885];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D7ED25CA434
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon May 25, 2026 at 1:40 PM CEST, Gary Guo wrote:
> On Mon May 25, 2026 at 5:37 AM BST, Eliot Courtney wrote:
>> On Fri May 22, 2026 at 8:34 AM JST, Danilo Krummrich wrote:
>>> +impl<'a, const SIZE: usize> Bar<'a, SIZE> {
>>> +    pub(super) fn new(pdev: &'a Device<device::Bound>, num: u32, name:=
 &CStr) -> Result<Self> {
>>
>> I think Sashiko's comment w.r.t. &CStrs in this patch looks accurate
>> and they should be 'static or at least 'a ish.
>
> It needs to be `'static` to be leak-safe.

Yes, it needs to be 'static as it is stored directly in struct resource. Th=
is
has been a bug without this patch already; I will insert a small fix for th=
is,
so it can be picked by stable separately.

Thanks,
Danilo

