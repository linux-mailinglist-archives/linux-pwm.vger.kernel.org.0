Return-Path: <linux-pwm+bounces-8053-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJEhGIQbgmmZPAMAu9opvQ
	(envelope-from <linux-pwm+bounces-8053-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 17:00:04 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE311DBA18
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 17:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E4313096B01
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Feb 2026 15:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4163C196B;
	Tue,  3 Feb 2026 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpTyWfQf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E903B8BCA;
	Tue,  3 Feb 2026 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770134371; cv=none; b=qPLZixAEA/8u+tp41yvuFyDu/qTFQFNhl54dtWRzloMXhVYyiq0qDc2FWirdxvnRW7mRYU30ZDwAOvfY2oZ3XZNopR1/eq2DkrFEQumW/3WmCSVdApN+cyEfbFKsf+64e43hHuc0KBx5hUkg5EX9G+7WfVbtnwCE5zZY8G/gT34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770134371; c=relaxed/simple;
	bh=HZpYlGDGLWaUHzG4EqbGI9XpE07voezN40184NbjljI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=g8rLXBdF/4x6VjaM5wodh+/slFmkJe/Omvy5/8dds/MMjfdl52Evi32+O18aN0wkbo0wsCZj9RMNBIyNhEDGYjHnKwL7DpOcvllYDlMzDsNHfgzrl2tzPGzsUwvxa2F/QJVIOOwVP6AlFw6AP8egMN1XdlFd2t60OTmFg9/Ek3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpTyWfQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7440CC16AAE;
	Tue,  3 Feb 2026 15:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770134371;
	bh=HZpYlGDGLWaUHzG4EqbGI9XpE07voezN40184NbjljI=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=hpTyWfQfad3gnwUPcoewPQ7AqjKvJino61gvUgByDN9F4vntrTHR7s2nfCi3x3VcY
	 UvP/TsTfY6l2JccJO/l0Nxh5r9eV2wmjC6ZC0wjvttD3IlQue4iGjya9tvs1LqL5MI
	 /mx38W/NIEJtypG1pswOHlmEe/Khz5JR/vabIdSSyj/mINx5teQB0cbl5z5Y+iTTkK
	 3BfDp80LdR3u4+4r9hqzMwHlZbAW+whMgEBW9nV4pYo8/1l65ESnvgsWLjdR50dAqA
	 o/qMllt5Wkd2V6vJ8SdNVFi1n4dvXM2JFUyx0tywMI2RAVlbfyoQaKPcCAXBmarft6
	 xIvi65xhIs6DQ==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Feb 2026 16:59:24 +0100
Message-Id: <DG5G9GZ3KB4Q.QCBC35TTSNWK@kernel.org>
Subject: Re: [PATCH v2 5/6] rust: debugfs: Allow access to device in
 Devres-wrapped scopes
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
 <20260203-qcom-socinfo-v2-5-d6719db85637@google.com>
In-Reply-To: <20260203-qcom-socinfo-v2-5-d6719db85637@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8053-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE311DBA18
X-Rspamd-Action: no action

On Tue Feb 3, 2026 at 4:46 PM CET, Matthew Maurer wrote:
> This adds support for creating a DebugFS directory which is aware that
> it is bound to a device. As a result, callbacks under that directory
> have access to a bound device which gives them efficient access to other
> Devres, ability to use dev_err! and friends, etc.
>

Suggested-by: Danilo Krummrich <dakr@kernel.org>

> Signed-off-by: Matthew Maurer <mmaurer@google.com>

Again,

Acked-by: Danilo Krummrich <dakr@kernel.org>

if this should go through another tree, but I can also pick it up.

