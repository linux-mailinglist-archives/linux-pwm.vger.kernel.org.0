Return-Path: <linux-pwm+bounces-9027-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FjEGH6dDGq8jwUAu9opvQ
	(envelope-from <linux-pwm+bounces-9027-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 19:27:26 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE420583080
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 19:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B56E3006784
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 17:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD55718050;
	Tue, 19 May 2026 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDT56KRN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9796B3DB339;
	Tue, 19 May 2026 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211394; cv=none; b=QRPT2o+eEiKjCcQomfeQEQkKSt1CeD5gvzydsTOdyQA94iqEuPPwkcyyUORbZwVydsQ/Cre24C67FOY6wErRHF9dE8pHQ2PNImgXNJyUryuf2cUwB0QtZ2rID5jEwa+RQaNQobNWAgxNnXFQCs9wm791EDMY5mG/PpgPXWyisoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211394; c=relaxed/simple;
	bh=4KWjZtWi5QWKT9x+Q+usG1SRhIzTYH6QGJOGse+O6c8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=In+1pAtBaNevruSvmU5RJVun8vlkW9SThDhSva7YGj09jjIWvjO1yeQkYTpz47FogPptCPMkJirHToAUKpSoW6LrkMcBF4ZgeS10j6OTBrOLaX9nnOh4Rj9nidX1qKcdlOkggkI+e5dmUmwEF7iBjU0pZibR6ZOaaqcqseVl8dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDT56KRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347C6C2BCB3;
	Tue, 19 May 2026 17:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779211394;
	bh=4KWjZtWi5QWKT9x+Q+usG1SRhIzTYH6QGJOGse+O6c8=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=sDT56KRNtEdXJk9FSMTUdKrZFWxTEGkiEE9DbCyL0Ideya3WopsxmqvIw5N69/jMh
	 S0uczmZhCjalS2HgRjS8oH3yeHg2FzXqE6Whnv8OwvS5vxKtXPGzrUHVUawlW5wl4x
	 He2xP+0K6ejnq/Kny8h8FHIlPjvieEqDBucD/1Co831Bq8roFrKbnorB5i9E+GkjDP
	 ug8HhWomIYkYOrCc2FgLslGu5eJdWSIU4bvB8OAeCQU/mCce55tZeR7575GMiSKDru
	 SMGOvqzSnIqo1Q8IOZE9ZHYOrwjeuHECOrdNx7ZLepNZw2q9IcqDjs2wQ21W0hh9B0
	 ws3f/U1RFm1FQ==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 19:23:05 +0200
Message-Id: <DIMTSQS1HZM9.326ZOXFP6PV5J@kernel.org>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 22/27] rust: driver-core: rename 'a lifetime to
 'bound
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-23-dakr@kernel.org>
 <DIMT8FK3A307.11FI5MGH9K1OX@garyguo.net>
In-Reply-To: <DIMT8FK3A307.11FI5MGH9K1OX@garyguo.net>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-9027-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BE420583080
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue May 19, 2026 at 6:56 PM CEST, Gary Guo wrote:
> On Sun May 17, 2026 at 1:01 AM BST, Danilo Krummrich wrote:
>> -    pub fn access<'a>(&'a self, dev: &'a Device<Bound>) -> Result<&'a T=
> {
>> +    pub fn access<'bound>(&'bound self, dev: &'bound Device<Bound>) -> =
Result<&'bound T> {
>>          if self.dev.as_raw() !=3D dev.as_raw() {
>>              return Err(EINVAL);
>>          }
>
> For the same reason that I outlined in the other email, I think this shou=
ld keep
> the generic `'a` name as this is not the actual lifetime of `'bound`, jus=
t a
> shortened one.

I think it depends on how you want to read it, i.e. do we consider 'bound t=
o be:

  - the lifetime for the full duration of a device bound to a driver, or
  - some lifetime that guarantees that the device remains bound for (which =
can
    also be shorter).

For this and the other cases you commented on I obviously applied the secon=
d
interpretation.

That said, I think for consistency and ambiguity reasons it does make sense=
 to
reserve the term 'bound for the first one exclusively, and also clearly doc=
ument
that.

