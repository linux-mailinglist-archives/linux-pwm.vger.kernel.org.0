Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 744F87FE71
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Aug 2019 18:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390593AbfHBQRR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 2 Aug 2019 12:17:17 -0400
Received: from vern.gendns.com ([98.142.107.122]:43374 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728853AbfHBQRO (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 2 Aug 2019 12:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Xh1krsXQ4OmAr0IgdObgohDnJErEyjk90MXL/lKpUtU=; b=gv/Y1onS6VrRWH9/CW7Ne05LMF
        wJhlJRZa/KUY8yP3RquMvvTs6/O6A7lxwbHkyk3XGYXmHtpt6yFPBY26EuNU64NgiXhCDBqp6YPrH
        8MFusQmZ+r9o+osnzLGO8PWtNFTGB2r+Hhp9s8vHwtbVmr9/qc0jTO+NRxZHmc4sIvz0mu3Hid2id
        k9WzyavVm4airyryyTmbwPq0eYvJjfBA+UQCwUYRO1hhNfDvNx+7s4rwmxnGvWKAxX+u9jxBYTO3J
        kwM5CYs5Oqbkf6ASOoGXYTCbSV8e3avp65xKQxjtesq0TPxxEH2n7CAxGoVGnS80fNqRgc3dqw0Yh
        XrVsq8PA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:42876 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <david@lechnology.com>)
        id 1htaEy-004w7U-Ps; Fri, 02 Aug 2019 12:17:12 -0400
Subject: Re: [PATCH 2/4] counter: new TI eQEP driver
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20190722154538.5314-1-david@lechnology.com>
 <20190722154538.5314-3-david@lechnology.com> <20190802092727.GB30522@icarus>
From:   David Lechner <david@lechnology.com>
Message-ID: <680ed555-c5db-6640-8fd3-121422077eff@lechnology.com>
Date:   Fri, 2 Aug 2019 11:17:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802092727.GB30522@icarus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 8/2/19 4:27 AM, William Breathitt Gray wrote:
>> +static const struct counter_ops ti_eqep_counter_ops = {
>> +	.count_read	= ti_eqep_count_read,
>> +	.count_write	= ti_eqep_count_write,
>> +	.function_get	= ti_eqep_function_get,
>> +	.function_set	= ti_eqep_function_set,
>> +};
> Are you able to provide a signal_read function, or are the Signals not
> exposed to the user by this device? Sometimes quadrature encoder devices
> provide an instanteous read of the signal lines to tell whether they are
> high or low, so I figured I'd ask.

No, it does not look like these signals can be read directly.

> 
> You should define an action_get function as well along with Synapses
> corresponding to each Signal. This will allow users to know whether the
> Synapse fires on a rising edge, falling edge, no edge, or both edges.
> 
> For example, consider the drivers/counter/104-quad-8.c file. Each count
> register has three associated signal lines: Quadrature A, Quadrature B,
> and Index.
> 
> Quadrature A and B are your typical quadrature encoder lines and
> depending on the function mode selected (quadrature x4, pulse-direction,
> etc.) could have a Synapse action mode of none, rising edge, falling
> edge, or both edges; see the quad8_synapse_actions_list array.
> 
> In contrast, the Index signal line only has two Synapse action modes:
> rising edge (in the case preset functionality is enabled) or none.

The encoders I have don't use the index or strobe signals, so I was
thinking maybe I should omit those two signals from the driver for the
time being since I don't have a way of testing.

> 
> For the TI eQEP driver, there will be four Synapses corresponding to the
> four Signals: QEPA, QEPB, QEPI, and QEPS. See if you are able to
> implement the Synapses and action_get function by using the 104-quad-8.c
> file as a reference. That file does have a lot of extra functionality
> tossed in compared to yours, so if you have trouble groking it, just let
> me know and I'll try to help.
> 

