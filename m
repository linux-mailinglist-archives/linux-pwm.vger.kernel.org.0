Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A2E21E777
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2020 07:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgGNFdG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Jul 2020 01:33:06 -0400
Received: from mga05.intel.com ([192.55.52.43]:55493 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbgGNFdF (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 14 Jul 2020 01:33:05 -0400
IronPort-SDR: yAnxvbBwHlM+WfbJTVsS6MdkDrrFxTq5cMQu76w3teMaVyFluWMJqXypZTanFE9QoHSzwBni9X
 In0hlTPHlqHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="233663854"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="233663854"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 22:33:05 -0700
IronPort-SDR: aDD1C1O4sqMlQQpAgdX8Ubkii5NHmQDCEZKGR//L+tb/3L9XUP/tPGA+UJCwWRAc/b+vovC09l
 Cy8acKKkmifg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="324445520"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jul 2020 22:33:05 -0700
Received: from [10.215.165.139] (rtanwar-MOBL.gar.corp.intel.com [10.215.165.139])
        by linux.intel.com (Postfix) with ESMTP id 57D3758080E;
        Mon, 13 Jul 2020 22:32:59 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] Add DT bindings YAML schema for PWM fan controller
 of LGM SoC
To:     Rob Herring <robh@kernel.org>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rahul.tanwar.linux@gmail.com
References: <cover.1593503228.git.rahul.tanwar@linux.intel.com>
 <cfef33c19b97a9cfbb8ecc0c6a122f3c9a5b46dd.1593503228.git.rahul.tanwar@linux.intel.com>
 <20200713164600.GA359372@bogus>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <b5832bbd-087e-4182-bea9-ed7b69626a8c@linux.intel.com>
Date:   Tue, 14 Jul 2020 13:32:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713164600.GA359372@bogus>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


Hi Rob,

On 14/7/2020 12:46 am, Rob Herring wrote:
> On Tue, Jun 30, 2020 at 03:55:31PM +0800, Rahul Tanwar wrote:
>> Intel's LGM(Lightning Mountain) SoC contains a PWM fan controller
>> which is only used to control the fan attached to the system. This
>> PWM controller does not have any other consumer other than fan.
>> Add DT bindings documentation for this PWM fan controller.
>>
>> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
>> ---
>>  .../devicetree/bindings/pwm/intel,lgm-pwm.yaml     | 50 ++++++++++++++++++++++
>>  1 file changed, 50 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml b/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
>> new file mode 100644
>> index 000000000000..120bf3d85a24
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
>> @@ -0,0 +1,50 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pwm/intel,lgm-pwm.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: LGM SoC PWM fan controller
>> +
>> +maintainers:
>> +  - Rahul Tanwar <rahul.tanwar@intel.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: intel,lgm-pwm
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  intel,fan-wire:
>> +    $ref: '/schemas/types.yaml#/definitions/uint32'
>> +    description: Specifies fan mode. Default when unspecified is 2.
>> +
>> +  intel,max-rpm:
>> +    $ref: '/schemas/types.yaml#/definitions/uint32'
>> +    description:
>> +      Specifies maximum RPM of fan attached to the system.
>> +      Default when unspecified is 4000.
> These are properties of the fan, not the PWM. And probably if you 
> need these properties then others would too, so they should be 
> common. Look at the pwm-fan.txt binding.

I checked pwm-fan.txt. I don't find any common property which matches
our fan properties of fan wire mode & max-rpm. Are you suggesting to
add these properties additionally in pwm-fan.txt as new common properties
and then use newly added generic name in our driver?

Also, we have a dedicated PWM fan controller. So do you think this driver
belongs to drivers/hwmon instead of drivers/pwm? Thanks.

Regards,
Rahul 

