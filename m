Return-Path: <linux-pwm+bounces-8315-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFbLL6x2vWmt9wIAu9opvQ
	(envelope-from <linux-pwm+bounces-8315-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 17:32:44 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB8B2DD6E4
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 17:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19D4E31AE5F0
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 16:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746483CD8BC;
	Fri, 20 Mar 2026 16:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b="po/zXRs4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF6F3CEBB9
	for <linux-pwm@vger.kernel.org>; Fri, 20 Mar 2026 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774023993; cv=none; b=YTTGX26bJ95LbChUoE7RzjYuhvalyWD5LhIl8i/+pifa6toU09FWF+9Y64du/B719sYI4N92fZUFu5EdjxqDFkbR9vMbjlLa3CMcCUPueDwjXmtB/wO82/TcbHrmFkSGcp6YMmgd5iBI95ApRM51IilLQiJaw9vznywjZOipqe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774023993; c=relaxed/simple;
	bh=fMyFSszCJXOXIv+DX7+R6wPDH9WSrMIYlywm/2fLRog=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=cqXhyYYrtZN5+LokrccCpJThEmfBDWWM06Sd+04sH17rMY0sJqqOBRJ4j5BPxiqMRWDqfIHSFpT+MLbajDHRRp63Ji0c7Bo+QTzDOwOhBOO3Jfwl2c/30poroLtq8yBDXTr/NJ7l0W5SoxyArLa4/is/xzm7pn9I0Cgbyg9ERD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com; dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b=po/zXRs4; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: Subject: Cc: To: From: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1774023991;
 bh=ft21UeP4z579XSbja1g9AqWPvCF44UV/oZHoOxBnDIs=;
 b=po/zXRs4NUieWFeWSsSAQKcclFR3SqRdF+vq/S/y703o3eouilHYvom1xnQFalPHp4KFvcfD4
 2O4c5Ccx6IW40xMm23tf8ZZgZLq7TutCCOMJI7dEksr39hNJGrbVt6+Q7lxDUolReUXe0GaKM6F
 CAS8O/bQa2TDgCZdt8R20IJe9Xxel+QHzKba2KW+TS1d+NNb4m8M3jTNuar8PVeb1e2Z6l9kzNT
 X+x+SUDhJVer311/5bSre37fkYuHCC/B1nNkz56LHoA8QTdjoBaJ1hGaCZxmqp8iJc0ZH1yn/kq
 71vv9gg+sKTQ15/iD56yNRtzEPgHxYPDWCJ65yk25Axw==
X-Forward-Email-ID: 69bd60d63c81f5afefaa2dca
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.6.53
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Fri, 20 Mar 2026 10:59:32 -0400
Message-Id: <DH7P658BN6Y6.2NN4PAO1KAEEQ@ubuntu.com>
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: "Janne Grunau" <j@jannau.net>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Lorenzo Pieralisi" <lpieralisi@kernel.org>, "Sven
 Peter" <sven@kernel.org>, "Neal Gompa" <neal@gompa.dev>, "Wim Van Sebroeck"
 <wim@linux-watchdog.org>, "Guenter Roeck" <linux@roeck-us.net>, "Linus
 Walleij" <linusw@kernel.org>, "Mark Kettenis" <kettenis@openbsd.org>, "Andi
 Shyti" <andi.shyti@kernel.org>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Sasha Finkelstein" <fnkl.kernel@gmail.com>
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <asahi@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <linux-watchdog@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux-i2c@vger.kernel.org>, <linux-pwm@vger.kernel.org>, "Michael Reeves"
 <michael.reeves077@gmail.com>
Subject: Re: [PATCH 0/9] Initial Apple silicon M3 device trees and
 dt-bindings
X-Mailer: aerc 0.20.0
References: <20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net>
In-Reply-To: <20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ubuntu.com,none];
	R_DKIM_ALLOW(-0.20)[ubuntu.com:s=fe-953a8a3ca9];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8315-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[jannau.net,kernel.org,gompa.dev,linux-watchdog.org,roeck-us.net,openbsd.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ubuntu.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jpeisach@ubuntu.com,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,lists.infradead.org,gmail.com];
	NEURAL_HAM(-0.00)[-0.833];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ubuntu.com:dkim,ubuntu.com:email,ubuntu.com:mid,jannau.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5FB8B2DD6E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri Mar 20, 2026 at 8:23 AM EDT, Janne Grunau wrote:
> Hej,
>
> This series adds initial device trees for M3 Apple silicon devices. The
> device trees contain only a minimal set of hardware not going much
> beyond the minimum required for booting kernel and initramfs and
> verify via serial console that the hardware and drivers work.
> The hardware with the exception of the interrupt controller is
> compatible with the M1 and M2 SoCs and the existing drivers.
> Changes for the interrupt controller were sent separately in [1] and are
> picked up and in linux-next. The device trees pass make dtbs_check with
> the apple,aic2 dt-bindings change from that series.
>
> Link: https://lore.kernel.org/asahi/20260223-irq-apple-aic3-v3-0-2b732807=
6b8d@jannau.net/ [1]
>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> Janne Grunau (9):
>       dt-bindings: arm: cpus: Add Apple M3 CPU core compatibles
>       dt-bindings: arm: apple: apple,pmgr: Add t8122 compatible
>       dt-bindings: power: apple,pmgr-pwrstate: Add t8122 compatible
>       dt-bindings: watchdog: apple,wdt: Add t8122 compatible
>       dt-bindings: pinctrl: apple,pinctrl: Add t8122 compatible
>       dt-bindings: i2c: apple,i2c: Add t8122 compatible
>       dt-bindings: pwm: apple,s5l-fpwm: Add t8122 compatible
>       dt-bindings: arm: apple: Add M3 based devices
>       arm64: dts: apple: Initial t8122 (M3) device trees
>
>  Documentation/devicetree/bindings/arm/apple.yaml   |   18 +
>  .../devicetree/bindings/arm/apple/apple,pmgr.yaml  |    4 +-
>  Documentation/devicetree/bindings/arm/cpus.yaml    |    2 +
>  .../devicetree/bindings/i2c/apple,i2c.yaml         |    4 +-
>  .../devicetree/bindings/pinctrl/apple,pinctrl.yaml |    4 +-
>  .../bindings/power/apple,pmgr-pwrstate.yaml        |    4 +-
>  .../devicetree/bindings/pwm/apple,s5l-fpwm.yaml    |    1 +
>  .../devicetree/bindings/watchdog/apple,wdt.yaml    |    4 +-
>  arch/arm64/boot/dts/apple/Makefile                 |    5 +
>  arch/arm64/boot/dts/apple/t8122-j433.dts           |   19 +
>  arch/arm64/boot/dts/apple/t8122-j434.dts           |   19 +
>  arch/arm64/boot/dts/apple/t8122-j504.dts           |   37 +
>  arch/arm64/boot/dts/apple/t8122-j613.dts           |   35 +
>  arch/arm64/boot/dts/apple/t8122-j615.dts           |   35 +
>  arch/arm64/boot/dts/apple/t8122-jxxx.dtsi          |   48 +
>  arch/arm64/boot/dts/apple/t8122-pmgr.dtsi          | 1149 ++++++++++++++=
++++++
>  arch/arm64/boot/dts/apple/t8122-usbpd-i2c.dtsi     |   32 +
>  arch/arm64/boot/dts/apple/t8122.dtsi               |  444 ++++++++
>  18 files changed, 1859 insertions(+), 5 deletions(-)
> ---
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> change-id: 20260319-apple-m3-initial-devicetrees-5c546ad977a2
>
> Best regards,

Seems fine, well done!

Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>

