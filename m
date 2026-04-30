Return-Path: <linux-pwm+bounces-8756-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAcNDxZb82lfzwEAu9opvQ
	(envelope-from <linux-pwm+bounces-8756-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Apr 2026 15:37:26 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C78C84A38CD
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Apr 2026 15:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67CED3009F87
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Apr 2026 13:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E63A427A0B;
	Thu, 30 Apr 2026 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiOIQGqV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098AA40629C;
	Thu, 30 Apr 2026 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777555985; cv=none; b=pPMUUzkkstPQdCyQJByl9DGPPHnVhIDSN1n2WyckaBTBPcfGHmW4G8AowMR89ykjQ39SCQWSoZtDN8OW6Ume+b5LOYipkyvlXGWgrQBblFGN0F3Etv3ABSbsmNxeTBEu5YYMN9xtK5X03bJZhifzonJE5ZlXV56SVfdNXHzwG9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777555985; c=relaxed/simple;
	bh=TEEc8oLJYjKcuMMITS7UO74STJHuTdOmDUG2VmTvs6A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=tD5LykYeSfkPPdgrobgZ+7bBie5VX3pURIxVjAsJnqABbXhkobJlcmE1EL6/pF06BP4dk7CyGlWb2/CVbz4k613Fgxdy6YaQw//YE9O3e5hx7wXtN0UU54TAJUDtV2OK7x4XICc+nek+KvVLSzY0BwwsGGwypuchz4E8owsP8dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiOIQGqV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450C9C2BCC6;
	Thu, 30 Apr 2026 13:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777555984;
	bh=TEEc8oLJYjKcuMMITS7UO74STJHuTdOmDUG2VmTvs6A=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=AiOIQGqVQ4l4oWxTRan90Ike9n4hOgtjcDPziSKOa6+I1AFEnON1/tNBHTaJVufYI
	 ceXvPn1UJOnJJ0C33XIFGGlUHqvYZQu0OeFXJeKFh3YCluo3EA0m9nvQQf4xDhYE/h
	 B0vW9c5nBoqZ0ioh6zqt/oU+mdEXdrx+gf7YBgGHmsxPibG+WmhxbTtkIpqwFNfLix
	 BU9MDEwhIEr2kfuEYKcHNfA7skdu78ivem3qEBVXAeasnot4tIiuoP/5UMoS1PFtPF
	 K9I90EUFQoubLRydnMSDtHrkJdvwAa54yhbyQtIG2zHrrL/2vaQj7aTshcti5wIWV7
	 4oJqZ/8LHkUWw==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Apr 2026 15:32:57 +0200
Message-Id: <DI6J06W5SFMQ.9MUTIC3SBG5Z@kernel.org>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <david.m.ertman@intel.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 01/24] rust: driver core: drop drvdata before devres
 release
References: <20260427221155.2144848-1-dakr@kernel.org>
 <20260427221155.2144848-2-dakr@kernel.org> <afMdCU06-Y2d_LXh@google.com>
In-Reply-To: <afMdCU06-Y2d_LXh@google.com>
X-Rspamd-Queue-Id: C78C84A38CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8756-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,nvidia.com,intel.com,linaro.org,samsung.com,google.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[30];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu Apr 30, 2026 at 11:12 AM CEST, Alice Ryhl wrote:
> On Tue, Apr 28, 2026 at 12:10:59AM +0200, Danilo Krummrich wrote:
>> Move the post_unbind_rust callback before devres_release_all() in
>> device_unbind_cleanup().
>>=20
>> With drvdata() removed, the driver's bus device private data is only
>> accessible by the owning driver itself. It is hence safe to drop the
>> driver's bus device private data before devres actions are released.
>>=20
>> This reordering is the key enabler for Higher-Ranked Lifetime Types
>> (HRT) in Rust device drivers -- it allows driver structs to hold direct
>> references to devres-managed resources, because the bus device private
>> data (and with it all such references) is guaranteed to be dropped while
>> the underlying devres resources are still alive.
>>=20
>> Without this change, devres resources would be freed first, leaving the
>> driver's bus device private data with dangling references during its
>> destructor.
>>=20
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> ---
>>  drivers/base/dd.c             | 2 +-
>>  include/linux/device/driver.h | 4 ++--
>>  rust/kernel/driver.rs         | 4 ++--
>>  3 files changed, 5 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index 5799a60fd058..be59d2e13a15 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -593,9 +593,9 @@ static DEVICE_ATTR_RW(state_synced);
>> =20
>>  static void device_unbind_cleanup(struct device *dev)
>>  {
>> -	devres_release_all(dev);
>>  	if (dev->driver->p_cb.post_unbind_rust)
>>  		dev->driver->p_cb.post_unbind_rust(dev);
>> +	devres_release_all(dev);
>>  	arch_teardown_dma_ops(dev);
>>  	kfree(dev->dma_range_map);
>>  	dev->dma_range_map =3D NULL;
>
> I seem to recall that we discussed a plan to have two classes of devres
> callbacks where device unbind proceeds as follows:
>
> 1. Run first class of devres callbacks.
> 2. Device is now considered unbound.
> 3. Run second class of devres callbacks.
>
> Is that still the plan?

Yes, it is -- I have most patches for this around and landed some devres
prerequisites last cycle.

Also note that this series already makes the situation better in this regar=
d,
since when drivers use HRT types rather than Devres, only Registration type=
s
remain to be guarded by devres.

