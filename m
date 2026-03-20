Return-Path: <linux-pwm+bounces-8311-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKlqCONXvWm69AIAu9opvQ
	(envelope-from <linux-pwm+bounces-8311-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 15:21:23 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C45232DBBA7
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 15:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 30B44300C032
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 14:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405633AC0DF;
	Fri, 20 Mar 2026 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1zICym7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E406278161
	for <linux-pwm@vger.kernel.org>; Fri, 20 Mar 2026 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774016480; cv=none; b=FgucMonoS1/YQEbvuUiIQk4CYGcUSWrRZFIY1hKgeClR4pK8VKPihMsPi8CcskwS4RyvMKLa/hLVVB2+RQjmBfJ/YzN3Y6T3evyexZY9NAgH40+Ov3eg6RgLeVQSuDQF/uuZZ//t6QkqQiyJzfj/aO078tcesHNxV2PtZi9oLAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774016480; c=relaxed/simple;
	bh=SqM2AKs946P+FYY/eyn1mHQZcwnT+QeDlAmSMReOErk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UGFDeUn5vxdYEJs25kZcPHGujA+RkHGh4xmGC2BPGJ/7NMZ3rq6AAWob6Z1tvC4WfParbJd9rcLuKceVytf8WNfPSQOZZSwvp5SCW+V0Y5iRvAE58didI0DrMcLG4q1Nw73pxdJfosqsvSZgETW1XIClZmfTUzM8jpnE3941AME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1zICym7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F250AC2BCB3
	for <linux-pwm@vger.kernel.org>; Fri, 20 Mar 2026 14:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774016480;
	bh=SqM2AKs946P+FYY/eyn1mHQZcwnT+QeDlAmSMReOErk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i1zICym7fUQjh+a/G2tiFppLoSbOQLYgTbPUF5kogGE7AA1epD7RkClPWEqRbzBRg
	 8COtuH5YKkcPMU6n/1IgKu7cp2SqSl9qPaLewylDLLcsm584AzbZ6yRxOM4RUIZpjG
	 nd1UALaqhQGCmMFEnCf0gJomdfXJ4gK5cxqLSheZFwO0lffebHn0BPXmYOyRbThojT
	 Iacqx5tJf6us+2248JJq8sTX2hCVKJTQ/LMdWlYmz5mcHtJEegVIj7S1A93rq3ILNs
	 ge4f7dLpaDWIAZJwdTrlwNWq6wo+MpSTV0YmoD265To4fRYML2u/QAau/CxrlaMeco
	 zsuzf+vk8xvtQ==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79801df3e42so28123997b3.0
        for <linux-pwm@vger.kernel.org>; Fri, 20 Mar 2026 07:21:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURzgRe65ordhrDnE386jteKiQFxDDf2Gr5hxPHuJz/tihl7zB5ajhOFf62sqLjtz+qCUiNUYiKrTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLXMk/c0gIBweVIrtaMQ+w8cQzxEnqYPPksgcyIbchH9b0GOMA
	MuFUdK8Zl6qqS5bSc0h0MrpWufZXrlXiUPR7eyaq9bYK75lcycm/XhDOpfFfOoQi1XCg5vQBY8+
	gt1LhWbd8xawDLXMTYdV0/VFkAOk1XMg=
X-Received: by 2002:a05:690c:60c2:b0:797:d46b:e86e with SMTP id
 00721157ae682-79a81a90a25mr75990057b3.14.1774016479055; Fri, 20 Mar 2026
 07:21:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net>
 <20260320-apple-m3-initial-devicetrees-v1-5-5842e1e393a8@jannau.net>
In-Reply-To: <20260320-apple-m3-initial-devicetrees-v1-5-5842e1e393a8@jannau.net>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 20 Mar 2026 15:21:07 +0100
X-Gmail-Original-Message-ID: <CAD++jLm42TDQCMrrz+8jkBZnKc7-Kbo26Kp8RR+XZhhGyow0OQ@mail.gmail.com>
X-Gm-Features: AaiRm51jFHpXl3P8yRKHiCPd9s1KCUcQyaH7BZV4EXHpuIPKoEs4F89iW4OvG24
Message-ID: <CAD++jLm42TDQCMrrz+8jkBZnKc7-Kbo26Kp8RR+XZhhGyow0OQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] dt-bindings: pinctrl: apple,pinctrl: Add t8122 compatible
To: Janne Grunau <j@jannau.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Sasha Finkelstein <fnkl.kernel@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8311-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gompa.dev,linux-watchdog.org,roeck-us.net,openbsd.org,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.931];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,jannau.net:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C45232DBBA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 1:23=E2=80=AFPM Janne Grunau <j@jannau.net> wrote:

> The pin controller on the Apple silicon t8122 (M3) SoC is compatible
> with the existing driver. Add "apple,t8122-pinctrl" as SoC specific
> compatible under "apple,t8103-pinctrl" used by the driver.
>
> Signed-off-by: Janne Grunau <j@jannau.net>

Looks good to me.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

