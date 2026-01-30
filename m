Return-Path: <linux-pwm+bounces-8016-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNM7NEOjfGmMOAIAu9opvQ
	(envelope-from <linux-pwm+bounces-8016-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 13:25:39 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 591F9BA771
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 13:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3C1C30300EC
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 12:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416573783CE;
	Fri, 30 Jan 2026 12:24:58 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3880036B05C;
	Fri, 30 Jan 2026 12:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769775898; cv=none; b=PNTm4qLOM7Pwf0aJH0uGc0B7EcZg8b0Je8EjmCy2xElN8su4p0tt/g7sPEkEtyVS8ULfLG5kb7z7EcIFPMq4hyFnu7XEZnMlhawNFPmW4eCU40BTERv9DQEfjYZ4dVZsmNM2SI0Bo0RmbD3OqyDDgtN/jVCSEP9mFzTdEjKIAC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769775898; c=relaxed/simple;
	bh=Pu/D/MqAtuCra0f6cMUDlK7OdIThQPfoBXULNMCwseE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V27swykVJXY6UgkIyefSuhDEwzPJWdEGsx8/ieWnP9fcWgHWdQQDnxFfKEhVjB7s1uMh3S7IdeUO+TL+jjvQdB5v9NOBguok2ARGYTaSsF1UdLhWjobvQb2VIZ/ivObeCgAE+8SCTp/MGCAhgdu1o5h/c136uIMgCjkZMBEcpu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: nX8ZW6YtRiKWK2Wj8EbUAA==
X-CSE-MsgGUID: BKHOHriOTaW2RkA2WX91Ug==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 30 Jan 2026 21:24:48 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.78])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 162454190888;
	Fri, 30 Jan 2026 21:24:44 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 0/5] Renesas MTU3 PWM / counter fixes
Date: Fri, 30 Jan 2026 14:23:48 +0200
Message-ID: <20260130122353.2263273-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8016-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[bp.renesas.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[cosmin-gabriel.tanislav.xa@renesas.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 591F9BA771
X-Rspamd-Action: no action

The Renesas MTU3 PWM and counter drivers have some issues which have
been observed while adding support for the Renesas RZ/T2H and RZ/N2H
SoCs.

This series fixes the most important issues which prevent normal
functioning of the driver, while other less important issues will be
handled in a future series.

Questions for the PWM maintainer:

1)

The handling introduced in patches 1 and 2 is similar to the approach
taken in commits [1] and [2].

Is this the right approach?

This code snippet below extracted from drivers/pwm/pwm-rzg2l-gpt.c
entirely prevents the period ticks from changing at all when two PWM
channels backed by the same HW channel are in use.

if (rzg2l_gpt->channel_request_count[ch] > 1) {
  u8 sibling_ch = rzg2l_gpt_sibling(pwm->hwpwm);

  if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, sibling_ch)) {
    if (period_ticks < rzg2l_gpt->period_ticks[ch])
      return -EBUSY;

    period_ticks = rzg2l_gpt->period_ticks[ch];
  }
}

Same logic has been imposed in patches 1 and 2 as the HW limitation is
similar.

Based on the logic here, a second channel can be enabled as long as its
period is larger than the period of the first enabled channel, and the
period and duty cycle will be adjusted to be <= to the period of the
first enabled channel.

But once the second channel is enabled, there's no way to adjust the
period of either channels anymore.

Wouldn't a better solution be that the smallest period between the two
channels is used, so that adjustment is still possible dynamically?

Here is an example.

echo 0 > /sys/class/pwm/pwmchip0/export
echo 1 > /sys/class/pwm/pwmchip0/export
echo 0xFFF000 > /sys/class/pwm/pwmchip0/pwm0/period
echo 0x7FF800 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle
echo 0xFFF000 > /sys/class/pwm/pwmchip0/pwm1/period
echo 0x7FF800 > /sys/class/pwm/pwmchip0/pwm1/duty_cycle
echo 1 > /sys/class/pwm/pwmchip0/pwm0/enable
echo 1 > /sys/class/pwm/pwmchip0/pwm1/enable

Now both LEDs are on, let's increase the period.

echo 0xFFFF000 > /sys/class/pwm/pwmchip0/pwm0/period
echo 0x7FFF800 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle

The effective period did not change.

echo 0xFFFF000 > /sys/class/pwm/pwmchip0/pwm1/period
echo 0x7FFF800 > /sys/class/pwm/pwmchip0/pwm1/duty_cycle

The effective period didn't change now either.

echo 0 > /sys/class/pwm/pwmchip0/pwm0/enable
echo 0 > /sys/class/pwm/pwmchip0/pwm1/enable

echo 1 > /sys/class/pwm/pwmchip0/pwm0/enable
echo 1 > /sys/class/pwm/pwmchip0/pwm1/enable

After turning the PWMs off and on again, the effective period is
updated.

If we were to change the period dynamically to the smallest one, the
LEDs would have changed their effective period without needing to be
turned off and on again.

Would this approach be better than the current approach? I can see that
other drivers just refuse updating the period entirely when the PWM
channels must share the same period.


2)

Another issue that I've encountered is that PWM is left enabled even if
the channel is unexported.

Here is an example.

echo 0 > /sys/class/pwm/pwmchip0/export
echo 0xFFFF000 > /sys/class/pwm/pwmchip0/pwm0/period
echo 0x7FFF800 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle
echo 1 > /sys/class/pwm/pwmchip0/pwm0/enable
echo 0 > /sys/class/pwm/pwmchip0/unexport

The connected LED is kept blinking as 0 was not written to enable.

Is this intended? Or should the PWM turn off on unexport?


3)

Should the .get_state() ops read the period and duty cycle from the
hardware if the PWM is not enabled?

Currently the MTU3 driver guards reading period and duty cycle based on
whether the PWM is enabled.

[1]: e373991eb9ff ("pwm: rzg2l-gpt: Accept requests for too high period length")
[2]: fae00ea9f003 ("pwm: rzg2l-gpt: Allow checking period_tick cache value only if sibling channel is enabled")

Cosmin Tanislav (5):
  pwm: rz-mtu3: fix prescale check when enabling 2nd channel
  pwm: rz-mtu3: impose period restrictions
  pwm: rz-mtu3: correctly enable HW channel 4 and 7
  counter: rz-mtu3-cnt: prevent counter from being toggled multiple
    times
  counter: rz-mtu3-cnt: do not use struct rz_mtu3_channel's dev member

 drivers/counter/rz-mtu3-cnt.c | 67 +++++++++++++-----------
 drivers/pwm/pwm-rz-mtu3.c     | 99 ++++++++++++++++++++++++++++-------
 include/linux/mfd/rz-mtu3.h   |  2 +
 3 files changed, 117 insertions(+), 51 deletions(-)

-- 
2.52.0


