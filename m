Return-Path: <linux-pwm+bounces-8565-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBTtMmmt3GnfVAkAu9opvQ
	(envelope-from <linux-pwm+bounces-8565-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Apr 2026 10:46:33 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8C73E946B
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Apr 2026 10:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1CDCF3004439
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Apr 2026 08:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7104B3A63F1;
	Mon, 13 Apr 2026 08:46:28 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBF837C93A;
	Mon, 13 Apr 2026 08:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776069988; cv=none; b=I3X8/ZuSk1wCq2Wa27HzoXLOrnHha9s11vw7qP9KsN/WGmNcSBAs2pagE87V3Q1MFJSW/5pcH/YBsb1pDxnRdtoTQbsZRGjzuKlhaF9tVjGt+sPtwoO6cX4mI6wU58jBRPUhiT1ZtoJkYs58gauVYNX20IHioZpRrRZVhbuz2+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776069988; c=relaxed/simple;
	bh=6enhhXH/CJEIPrzagw+rdyNIsjC87WLeT+KTFs81HfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WrhkUQ988D7iTY+g+M8+Okfun4SzI1SFLtBeoP7V6lb1+GZ7X5fxzK2VIYt6L/lKmPSXKBH+WAqTuQxjKTFICJbPoWqc6RZhUhRwj+HPVa6+th8NV10swNBzYpIxT6G8l9WIcJuWJNYpi3iUtH+bKwO8zeMavYlcuGBJPYb2Jro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: esmtpsz11t1776069934tc0e6f556
X-QQ-Originating-IP: 5r2GTatSwY3Uul1iODbL62wL+DJW79DDgHXv81kb6e8=
Received: from [127.0.0.1] ( [116.234.85.158])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 13 Apr 2026 16:45:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15065568213300330693
Message-ID: <CEA509826F1319B9+712fdfb3-916a-44fb-bca7-1c5c8b81cd91@radxa.com>
Date: Mon, 13 Apr 2026 16:45:31 +0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: pwm: clk-pwm: add optional GPIO and
 pinctrl properties
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260406-clk-pwm-gpio-v1-0-40d2f3a20aff@radxa.com>
 <20260406-clk-pwm-gpio-v1-1-40d2f3a20aff@radxa.com>
 <adyr_17yvFGkihU5@monoceros>
Content-Language: en-US
From: Xilin Wu <sophon@radxa.com>
In-Reply-To: <adyr_17yvFGkihU5@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NBwM60nxo3yxgNwuJcwZlEMVEv5UIyREsG3wZ+GSNkhtSnn7vegPhR4M
	uc107NI0HDW8SO8OYOfB0EwAf9GCh7dK4Q9rtn/DdpU7t1IRceWU1plVfEUoEEPUprofZpE
	ddbNNGX+FkW9QV7xy2/+Zv1+tCu0qxNDNuV3VOKnkMs3W7mVOhIGotw/TrSCfFg0QS2YxPy
	VnhVqjyX6VGSiUZUhdvpGCReoR2+FA+ET3CWAj88opAclo5dGVYLVa6hkErZNksvrfoXglh
	Ct7z0a/2VvtqHDeQ9gaimCx62Vyr9yx7l5W5jo4a7q0XLMeftLSo3pnfa+rYiq2h5eBbw2K
	gis27pGLVeW9IyaBeUm7c5QGAhoIGu45erJK72wb1iIpvn05AF5wBtXtRuBt4Q04OqFswtJ
	YBbty7LlMOFI9wNKVDloeO0dYz5NY7AzgvNLbZLOJXRazSm6G/XawT0BF3iOmPZ/CPkMqJC
	LNec8f1Y8taE/9c3HHQZ7np/Vh/38CdlReZSAb5poikgoDr4IFaKaCYl8ZkffvfQlGHycms
	dcgyGTajsHMkZJtA1hPTgRFdbbdxEcWk4VHMwxTxpK/ZmSWER+p6BuJkUhRKsXTwkXVOOeT
	k2BqXpHFwng/L4ebGhhyXvFBtSl0zTads9lZWZXGYWug1Bs3BEcRiYAssu/q/Dvve8IbWWW
	3ji4ZXo5Ky3NGxF0gice8t2Fxd/cygfMJBmjZx2D4UIu5ghSEDZorND3cxfSXAdyjBczsNo
	fF2Rv50nKiqvu6uJZMghPU5L1saui5+JWfAD/JyWSHoWg4YclOGpFidCCblvTmcNOzUEAB6
	T2nUJHjUY+TavO6b3lbVNVxtTolEUBqJFAx9Oypl7HgC3VT+GiWZhWjgCOy5D+9HavWTU3a
	lJat/XAzMkCwUpZbbQxrmRSU0GurhGFacGEKZlNK1f0T9UN3K2ELXBFOdGJZ8dYjLnCvrEa
	A2/OdEV1aY52z/xE7RAqhzEt3gGFwKkmHPtHxtVBvfAMpuevXAoisO2jLcGm6X56mgxY=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[radxa.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8565-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_MUA_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sophon@radxa.com,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,radxa.com:email,radxa.com:mid]
X-Rspamd-Queue-Id: DE8C73E946B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/2026 4:41 PM, Uwe Kleine-König wrote:
> Hello,
> 
> On Mon, Apr 06, 2026 at 11:50:01PM +0800, Xilin Wu wrote:
>> The clk-pwm driver cannot produce constant output levels (0% or 100%
>> duty cycle, or disabled state) through the clock hardware alone - the
>> actual pin level when the clock is off is undefined and
>> hardware-dependent.
>>
>> Document optional gpios, pinctrl-names, pinctrl-0, and pinctrl-1
>> properties that allow the driver to switch the pin between clock
>> function mux (for normal PWM output) and GPIO mode (to drive a
>> deterministic constant level).
>>
>> Signed-off-by: Xilin Wu <sophon@radxa.com>
>> ---
>>   Documentation/devicetree/bindings/pwm/clk-pwm.yaml | 36 +++++++++++++++++++++-
>>   1 file changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/clk-pwm.yaml b/Documentation/devicetree/bindings/pwm/clk-pwm.yaml
>> index ec1768291503..2a0e3e02d27b 100644
>> --- a/Documentation/devicetree/bindings/pwm/clk-pwm.yaml
>> +++ b/Documentation/devicetree/bindings/pwm/clk-pwm.yaml
>> @@ -15,6 +15,11 @@ description: |
>>     It's often possible to control duty-cycle of such clocks which makes them
>>     suitable for generating PWM signal.
>>   
>> +  Optionally, a GPIO and pinctrl states can be provided. When a constant
>> +  output level is needed (0%, 100%, or disabled), the pin is switched to
> 
> A constant output isn't needed when disabled. The state is undefined
> then. A plain clk_disable() is fine then.
> 
> Best regards
> Uwe

Ack. I will change the binding description and the driver behavior in 
the next revision.

Thank you for the review.

-- 
Best regards,
Xilin Wu <sophon@radxa.com>


