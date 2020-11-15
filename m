Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBD02B362A
	for <lists+linux-pwm@lfdr.de>; Sun, 15 Nov 2020 17:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgKOQ3x (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 15 Nov 2020 11:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbgKOQ3x (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 15 Nov 2020 11:29:53 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CA5C0613D1;
        Sun, 15 Nov 2020 08:29:52 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id w142so21332410lff.8;
        Sun, 15 Nov 2020 08:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iC9NSUeuoXzI+DJbqq71H2Zz0PQEqB1OwlXCJ9ZyVwE=;
        b=N7DU2s8hAlj9xxkzQ2I8PyHCG7D4tPHsZrBs/ZFTlGrlirNJ+FBBIUJ4LHFrjKqWVr
         +tHu5pFQ1UAsCz/st6d7bfBh/LEXy197nXKpgcLGFYW+Ak4Qv6V5arl0k+F2HQpie5bl
         28dTS7uRV3HinpiMSG5Lg77AcaJhJh7zdmtFET43lJ976UdhLpqz0pJg02ntLGKwDMqG
         v6xDQCBvQwNcgz9eAKwbDlodqN7Pz9vYe6lJDZp3pyzKA0aXPLlIJzDHhAgbCk3BJy+Z
         BOdAQN6CMDBtaaILm6TDc1MDsszvkY4ZxTyCMuB6VC+H+tTrMb5FJcfFF6rA7vBMVoBI
         JEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iC9NSUeuoXzI+DJbqq71H2Zz0PQEqB1OwlXCJ9ZyVwE=;
        b=t7rXUi/Yi1x/l7PlwPr2UK2i0nQoXLJk6paemfvobN4M4B6RWwHgC0PlmsBH04Zvrh
         /96KGKQmMI7gASJQJ66MhZK1hl2RVQitslmVgk/P4OsIzCTSBIXdweX84nsLuXeW+ziQ
         8MNif4xdtZX5FF1ncuscf0bEFkl7lT24SBHVNWSU+3mMu2gfOc/cfrYBh2F3FY/TgxXy
         D4+OPtiGWQgr8HIwB5djychm1Xl0h31ZOrtWg69i4szyGW+1EPMoaMC+6QbB7SYeJctm
         FW8/J0pPbjZRKPPCLMdgw7yawc4jbfY8Tme3GGXZ0I1Qc2YKHrcu9zFibH5OX+EEcX/d
         WLDw==
X-Gm-Message-State: AOAM53193u2TVV+HOavOkinY24GgrMe6WAVyUZnkWrNEUJelkiJXX1rK
        bzuhXpGNn7OPkWz5I2TQDlQnv6bKuEk=
X-Google-Smtp-Source: ABdhPJyKAFx5NAC66gNXmBbXVldpY/Bu7QhCg9tdHj3K5FHem1m7FQns7xPp+/vK1tkSo2/TIWesZQ==
X-Received: by 2002:ac2:44d2:: with SMTP id d18mr4229194lfm.103.1605457790581;
        Sun, 15 Nov 2020 08:29:50 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id i19sm2371286lfj.212.2020.11.15.08.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2020 08:29:49 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v1 00/30] Introduce core voltage scaling for NVIDIA
 Tegra20/30 SoCs
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <Peter.Chen@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <20201104234427.26477-1-digetx@gmail.com>
 <CAPDyKFr7qTU2RPhA_ZrbCayoTTNUEno1zdmvmv+8HBe-Owrfeg@mail.gmail.com>
 <cd147ab0-1304-a491-7a56-ee6199c02d32@gmail.com>
 <2716c195-083a-112f-f1e5-2f6b7152a4b5@gmail.com>
 <CAPDyKFqUMsH9dCZ=OYqfdLt==+-8NjK9n=S5jGGNXZu6Y9q=2w@mail.gmail.com>
 <1f7e90c4-6134-2e2b-4869-5afbda18ead3@gmail.com>
 <20201112204358.GA1027187@ulmo>
 <25942da9-b527-c0aa-5403-53c9cc34ad93@gmail.com>
 <20201113163552.GE1408970@ulmo>
Message-ID: <a89211b7-13c4-41dd-df42-d0f01a880566@gmail.com>
Date:   Sun, 15 Nov 2020 19:29:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201113163552.GE1408970@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

13.11.2020 19:35, Thierry Reding пишет:
> On Fri, Nov 13, 2020 at 01:14:45AM +0300, Dmitry Osipenko wrote:
>> 12.11.2020 23:43, Thierry Reding пишет:
>>>> The difference in comparison to using voltage regulator directly is
>>>> minimal, basically the core-supply phandle is replaced is replaced with
>>>> a power-domain phandle in a device tree.
>>> These new power-domain handles would have to be added to devices that
>>> potentially already have a power-domain handle, right? Isn't that going
>>> to cause issues? I vaguely recall that we already have multiple power
>>> domains for the XUSB controller and we have to jump through extra hoops
>>> to make that work.
>>
>> I modeled the core PD as a parent of the PMC sub-domains, which
>> presumably is a correct way to represent the domains topology.
>>
>> https://gist.github.com/digetx/dfd92c7f7e0aa6cef20403c4298088d7
>>
>>>> The only thing which makes me feel a bit uncomfortable is that there is
>>>> no real hardware node for the power domain node in a device-tree.
>>> Could we anchor the new power domain at the PMC for example? That would
>>> allow us to avoid the "virtual" node.
>>
>> I had a thought about using PMC for the core domain, but not sure
>> whether it will be an entirely correct hardware description. Although,
>> it will be nice to have it this way.
>>
>> This is what Tegra TRM says about PMC:
>>
>> "The Power Management Controller (PMC) block interacts with an external
>> or Power Manager Unit (PMU). The PMC mostly controls the entry and exit
>> of the system from different sleep modes. It provides power-gating
>> controllers for SOC and CPU power-islands and also provides scratch
>> storage to save some of the context during sleep modes (when CPU and/or
>> SOC power rails are off). Additionally, PMC interacts with the external
>> Power Manager Unit (PMU)."
>>
>> The core voltage regulator is a part of the PMU.
>>
>> Not all core SoC devices are behind PMC, IIUC.
> 
> There are usually some SoC devices that are always-on. Things like the
> RTC for example, can never be power-gated, as far as I recall. On newer
> chips there are usually many more blocks that can't be powergated at
> all.

The RTC is actually a special power domain on Tegra, it's not a part of
the CORE domain, they are separate from each other.

We need to know what blocks belong to a power domain and what's the
power topology of these blocks. I think we already have this knowledge,
so it shouldn't be a problem.

>>> On the other hand, if we were to
>>> use a regulator, we'd be adding a node for that, right? So isn't this
>>> effectively going to be the same node if we use a power domain? Both
>>> software constructs are using the same voltage regulator, so they should
>>> be able to be described by the same device tree node, shouldn't they?
>>
>> I'm not exactly sure what you're meaning by "use a regulator" and "we'd
>> be adding a node for that", could you please clarify? This v1 approach
>> uses a core-supply phandle (i.e. regulator is used), it doesn't require
>> extra nodes.
> 
> What I meant to say was that the actual supply voltage is generated by
> some device (typically one of the SD outputs of the PMIC). Whether we
> model this as a power domain or a regulator doesn't really matter,
> right? So I'm wondering if the device that generates the voltage should
> be the power domain provider, just like it is the provider of the
> regulator if this was modelled as a regulator.

Technically this could be done and it shouldn't be difficult to add
GENPD support to the regulator framework, but I think this is an
inaccurate hardware description.

It shouldn't be correct to describe internal SoC parts as
directly-connected to an external voltage regulator. The core voltage
regulator is connected to a one of several power rails of the Tegra
chip. There is no good way to describe hardware in terms of voltage
regulators, hence that's why this v1 series added a core-supply to each
SoC component of each board's DT individually.

It's actually one of the benefits of using a separate DT node for the
power-domain, which describes the "Tegra Core" part of the Tegra SoC,
and thus, it all stays within tegra.dtsi. This means that PD explicitly
belongs to the SoC internals in oppose to describing PD like it's an
external/off-chip component.

Initially I didn't like much that there is no hardware address to back
up the power domain node in a DT, but actually there is no address for
the power rail. Hence it should be better to describe hardware by
keeping PD internally to the SoC. Note that potentially PD may require
knowledge about specifics of a particular SoC, while external regulator
doesn't belong to a SoC. Also, I guess technically there could be
multiple external regulators which power a single SoC rail.
