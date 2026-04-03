Return-Path: <linux-pwm+bounces-8462-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IN1bGrmQz2lqxQYAu9opvQ
	(envelope-from <linux-pwm+bounces-8462-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Apr 2026 12:04:41 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D088F3931C6
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Apr 2026 12:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B658B3025155
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Apr 2026 10:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4328382285;
	Fri,  3 Apr 2026 10:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ucio1low"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F48370D77
	for <linux-pwm@vger.kernel.org>; Fri,  3 Apr 2026 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775210670; cv=pass; b=A25orf3WRZLHhIpil1F9R3WoyP62VAKQe7Zj24hlsshy6RS6tWfnLUeWXUpzlQ2ZVtOH1wt+ozTeR7cQLwScB/oZVbFm5UYkSBl8TBshm7WEcFN/XEv3hqEsmqMS2ZPcmcaynLjj1Rh1vXU8NJ6RfXZ0i36VsA8xGp6fuQ7y6CQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775210670; c=relaxed/simple;
	bh=5Ub2qm2j/9wtMhk2YXDRQubiyelrtrH9hR7TQ8pFlUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ktzKUXetxqleIzz2Ajt28WA76CCgyt15Lk438yFLSVcQGD3ZxT3jrpuHDZFVvpJc2pcmwpfS+tSajQ2NCMKcpW75oO4yf1P3pi2P6VI56K5OY3NPkRTcOQ7vif4a6qPq8j7dWOHoMradDpD8Kd/ai3cmzIkrFm670zsebYWgzqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ucio1low; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2cb19ddda43so130581eec.3
        for <linux-pwm@vger.kernel.org>; Fri, 03 Apr 2026 03:04:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775210662; cv=none;
        d=google.com; s=arc-20240605;
        b=PPxwaQsteKbJO/Hx5jm/sEri4UTj/4qLGpkR/dvAOELG3ThSWPtfbp6zXmr2auck1x
         QjjPj4RpK4Dn7azMCLUvuoT+/cnwrJ8Cw4uuImo1lK9SIRK7MNUEMFxMhLY6a59QCJhb
         KH0RITg9X50FR4FvDugIONxM8E3mQMCsozmy5500yjYaHxnTqTp7MrZ0bVMIzHzrv0HX
         1tuYwFYB4+pB0cMoC/pIBg/1K8Dj1bB2QiiEW6KBQ/JbMy4yGi0HNdpLYcxq8bmZUjuV
         yFhKkECfOJ0Kt9EK/7w60FIBlR0PCunQlLHbH/7dlE0phMV3R7jOr74pg/cU3SBfZMho
         PZSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5Ub2qm2j/9wtMhk2YXDRQubiyelrtrH9hR7TQ8pFlUk=;
        fh=7GOrDsYYf5cvPWZuCOpKd1GxW59fyE2XS7bt4UQV0d4=;
        b=H3dLyyHrA2xncQw7VlH34usol4/A8dekmR45wZPsm+NLt0AtMx9v3z/z9KnOXoNrsJ
         gOQFO3unBtpM1tf6ZSb/HniCahIoImWtZeXz9J/6r0dqkoHDbuCzWYtYmaV/GLRESSX6
         5VyXpD503HsjFAJYVa7RYL3kTn0HmehO/1aDhK29USF/vlYwYZYnzE0w+Gwswyx0U4e+
         U8hvfYTq3N/ah+vv1QcBAn5vK1LTroSF+f1ciKGL3S6jWHLSRfBNAPm4PzluFwfQhPDv
         p/vWzQc3x1t8XC75pX4AVkaGpctGJZqKGWFqqJuBmXhsMkAj2/pBYgK+ytJvTg8UAqIg
         cBCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775210662; x=1775815462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Ub2qm2j/9wtMhk2YXDRQubiyelrtrH9hR7TQ8pFlUk=;
        b=Ucio1lowb9WylS43hrVgY2EBZDDnSMm+rOs4JZEGD39u3SOD6X3DzoUZkXcElf1L0+
         x6qGG/xFzNUl9ibjkl3by7YUBHYbXUjDqAZT8bWTZoKo7bl05cIj390K1pums52yFob9
         +5u18jLKs41BlAoSQ8AgAmtnCLrQ5jV71t6A1agz8VPTk/wSl8+Z3Heoh5oOi48aOLFU
         Bbu6+RCan8oMZY1M6QyJt0blR/wgp4I+IUfAc0DpfOzk6NfvZQ6F4OuaqQeNY2XfSRug
         KflFdMN6p+LhmhBdOrMCwI9eV/a5ElYf2MtBjifFwn/f7ZeAkrPgxBIPubyl9LXR4uho
         dQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775210662; x=1775815462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Ub2qm2j/9wtMhk2YXDRQubiyelrtrH9hR7TQ8pFlUk=;
        b=qSR8zlnJ8iEDFWCoczag3XBXZDgjrT4vDelKyS/8k7/6sgJqB8C8AY/xR40E7A1OjB
         8loXyyhkEB6nzhPjPcWjW2OYtYHopL6KQT8WrMrHTpUATwu1D+QFtZ/42abkhxBCbipC
         Ao5sL1e8I3aat6ZvV+nSLJb18D1QuSb3RG2dsutfWS+lv+YxMY4Boxrny0VULsPy6ak/
         cbgJhbxzZ3okjmzonvKRfTed/hHQkacQw96va5CrDdbeBibYJ/+A1JLb/I8yjpMYjorX
         W4MLFeivFvdOnlNyj49PQbDRlHSX0tjhT4ZqaLXyLXPzweYbZyw0Y4M5bZWCW8rPpyE6
         B4dA==
X-Forwarded-Encrypted: i=1; AJvYcCUR6kfUL6wtQvNES0/X8j6O12M9PkCmvDKov+zAhDTmETyoB2CfZSGMDfed/81O9iMnYOvd8AFD2Ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvHDsZaSf9jGR+qvWiFq6cHysWR+x8Mz2bXOBP4fVHAedtBa9C
	muKyAp4/EsURSgaeoPpyA+i+5MvPzreQ4Z/fG5eIXbUfMasF6sjdL/RLYuC+ZFU8d9MzsboFWtl
	os57LR9xEnpqZPbC7mIHxYz+fME7hfmY=
X-Gm-Gg: AeBDieufCPfk/8Dajk4Gk5Hnt5owvexoMlNT/AXxjvGH8xEeU282nKPC2GTkDQ2X6Nn
	HQSbpvkuzc/qzOFeO+do9hYqRSCf2PbcLqS2RXB3nvnkdjluitW63AbqyomF3QpObUR/HgJPB4L
	cJu5D95PwaFlEFQbwILn6TkFmgD3P/C8kkbuCupSNcuOZtjbW4Ebo6ebfY8+ldFI+Pi3gO0xnfV
	6AvGs8XLMBuXB0z6ILohb3t8IJ8QZWWCRQ0hlKoVxFA5IZKRAfwBUAwcZcw/DH6V/+DzWkM7vAL
	PWZz/Zi6MKYEqzSUhaDPo0jep1n3uz55fmeCCwbuZ1RfGkk0FDcd768zCBMPUMvujkIqjrLSywq
	C7vsdzt6osHx6IygtVt/v2KigbVH0rzXOrQ==
X-Received: by 2002:a05:7301:129a:b0:2c1:7ca:cec2 with SMTP id
 5a478bee46e88-2cbfce5068dmr491773eec.8.1775210662077; Fri, 03 Apr 2026
 03:04:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
In-Reply-To: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 3 Apr 2026 12:04:09 +0200
X-Gm-Features: AQROBzDGWGQe8LG7T9EapBc3mqC597eB6i8cF8SGIYhy3xFBCktFl3DRWuS1lDc
Message-ID: <CANiq72kZOtA27UuDZztLCAfR2rLeO=1a_ajAaza4idrC8AzDog@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Implement Send and Sync for clk
To: Alice Ryhl <aliceryhl@google.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, linux-clk@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org, 
	Boqun Feng <boqun@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8462-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,baylibre.com,linux.intel.com,redhat.com,samsung.com,linaro.org,garyguo.net,protonmail.com,umich.edu,collabora.com,vger.kernel.org,lists.freedesktop.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D088F3931C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Feb 23, 2026 at 11:08=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> The Clk type is thread-safe, so let's mark it as thread-safe in the type
> system. This lets us get rid of hacks in drivers.

Applied to `rust-next` -- thanks everyone!

(Given we heard nothing this week either)

Cheers,
Miguel

